import express from "express";
import session from "express-session";
import crypto from "crypto";
import bodyParser from "body-parser";
import pool from "./db.js";
import multer from "multer";
import path from "path";
import nodemailer from "nodemailer";


// Multer
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'public/img/produit'); 
    },
    filename: (req, file, cb) => {
        const ext = path.extname(file.originalname);
        const uniqueName = 'Prdt' + Date.now() + ext;
        cb(null, uniqueName);
    }
});



const upload = multer({ storage: storage });

const app = express();
app.set("view engine", "ejs");

app.use(express.static('public'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true,
}));

//MIDDLEWARES MAISON
function authenticate(req, res, next) {
    if (req.session.hasOwnProperty("userId")) {
        next();
    }
    else {
        res.status(403).redirect("connexion")
    }
}

function isAdmin(req, res, next) {
    if (req.session.userRole == "Admin") {
        next();
    }
    else {
        res.status(403).redirect("/");
    }
}



//protéger une page (rajout d'authenticate et par ex isAdmin)
// app.get("/", authenticate, isAdmin, async function(req,res){
//     //récupération bdd (code à réutiliser pour les autres routes)
//     let data = await pool.query("SELECT * FROM produit");
//     res.render("index", {variable : data});
// });

//

// ROUTES




app.get("/", async function (req, res) {    
    if (req.session.role === "admin") {
        res.render("/admin/index");
    } else {
        res.render("index");
    }
});

app.get("/contact", async function (req, res) {
    res.render("contact");
});

app.get("/presentation", async function (req, res) {
    res.render("presentation");
});


app.get("/catalogue_produit", async function (req, res) {
    const domaine = req.query.valeur;
    const type = req.query.type;

    try {
        //Récupération des produits
        let sql = "SELECT * FROM produits WHERE 1=1";
        let params = [];
        if (domaine) {
            sql += " AND domaine = ?";
            params.push(domaine);
        }
        if (type) {
            sql += " AND type = ?";
            params.push(type);
        }

        const [produits] = await pool.query(sql, params);

        const produitsAvecDisponibilite = produits.map(p => ({
            ...p,
            disponible: p.disponibilite === 1
        }));

        // Récupération des types
        const [types] = await pool.query(
            "SELECT DISTINCT type FROM produits WHERE domaine = ?",
            [domaine]
        );

        //  Récupération des articles de blog (uniquement pour arboriculture)
        let blog_articles = [];
        if (domaine === "arboriculture") {
            const [articles] = await pool.query(
                "SELECT * FROM blog_arbo ORDER BY date_publi DESC"
            );
            blog_articles = articles;
        }

        //  Rendu de la page avec blog_articles inclus
        res.render("catalogue", {
            produits: produitsAvecDisponibilite,
            categorie: domaine,
            types,
            blog_articles
        });

    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur serveur");
    }
});


app.get("/connexion", function (req, res) {
    res.render("connexion");
});


app.get("/produit", async function (req, res) {
    const produitId = req.query.produit_id;
    const [produit] = await pool.query("SELECT * FROM produits WHERE id = ?", [produitId]);
    const domaine_produit = produit[0].domaine;
    // Sélectionner 3 produits aléatoires du même domaine, en excluant le produit actuel
    const peut_plaire_requete = "SELECT * FROM produits WHERE domaine = ? AND id <> ? ORDER BY RAND() LIMIT 3";
    const [peut_plaire] = await pool.query(peut_plaire_requete, [domaine_produit, produitId]);

    res.render("produit", { produit: produit[0], peut_plaire });
});





// ADMIN

app.get('/deconnexion', (req, res) => {
    req.session.destroy(err => {
        if (err) {
            console.error("Erreur lors de la déconnexion :", err);
            return res.redirect('/admin'); 
        }
        res.redirect('/'); 
    });
});

app.get('/admin/index', async function (req, res) {

    let produits_aime = await pool.query("SELECT * FROM produits LIMIT 5");
    res.render("admin/index", {
        produits_aime: produits_aime[0],
        prenom: req.session.nom
    });
});


// Route pour afficher le formulaire d'ajout d'un produit
app.get("/admin/ajout_produit", async (req, res) => {
    try {
        // Récupérer les types et domaines existants pour remplir les sélecteurs dans le formulaire
        const [types] = await pool.query("SELECT DISTINCT type FROM produits");
        const [domaines] = await pool.query("SELECT DISTINCT domaine FROM produits");

        res.render("admin/ajout_produit", {
            types,
            domaines
        });
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur serveur");
    }
});

// Route pour afficher la liste des produits à modifier
app.get("/admin/modif_produit", async (req, res) => {
    try {
        const [produits] = await pool.query("SELECT * FROM produits");
        res.render("admin/modif_produit", {
            produits
        });
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur serveur");
    }
});

// Route pour traiter le formulaire d'ajout de produit
app.post("/admin/ajout_produit", upload.single("image"), async (req, res) => {
    try {
        const { nom_produit, variete, prix, domaine, type, disponibilite } = req.body;
        const image_path = req.file ? `/img/produit/${req.file.filename}` : null;

        await pool.query(
            "INSERT INTO produits (nom_produit, variete, prix, domaine, type, disponibilite, image_path) VALUES (?, ?, ?, ?, ?, ?, ?)",
            [nom_produit, variete, prix, domaine, type, disponibilite ? 1 : 0, image_path]
        );

        res.redirect("admin/ajout_produit");
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur serveur lors de l'ajout du produit");
    }
});

// Route pour traiter la modification d'un produit
app.post("/admin/modif_produit/:id", upload.single("image"), async (req, res) => {
    try {
        const produit_id = req.params.id;
        const { nom_produit, variete, prix, domaine, type, disponibilite } = req.body;
        let image_path = req.file ? `/img/produit/${req.file.filename}` : null;

        // Si aucune nouvelle image, ne pas écraser l'ancienne
        if (!image_path) {
            const [rows] = await pool.query("SELECT image_path FROM produits WHERE id = ?", [produit_id]);
            if (rows.length > 0) image_path = rows[0].image_path;
        }

        await pool.query(
            "UPDATE produits SET nom_produit = ?, variete = ?, prix = ?, domaine = ?, type = ?, disponibilite = ?, image_path = ? WHERE id = ?",
            [nom_produit, variete, prix, domaine, type, disponibilite ? 1 : 0, image_path, produit_id]
        );

        res.redirect("/admin/modif_produit");
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur serveur lors de la modification du produit");
    }
});


app.get('/admin/liste_produits', async function (req,res){
    const liste_produits = await pool.query("SELECT * FROM produits")
    res.render("admin/liste_produits", {produits:liste_produits[0]})
})


app.get("/admin/catalogue_produit", async function (req, res) {
    const mode = req.query.mode;
    const domaine = req.query.valeur;
    const type = req.query.type;

    try {
        let produits = [];
        let blog_articles = [];
        let types = [];

        if (domaine === "arboriculture") {

            if (req.query.mode === "blog") {
                const [articles] = await pool.query("SELECT * FROM blog_arbo ORDER BY date_publi DESC");
                blog_articles = articles;
            }

            if (req.query.mode === "produits") {
                let sql = "SELECT * FROM produits WHERE domaine = ?";
                let params = [domaine];

                if (type) {
                    sql += " AND type = ?";
                    params.push(type);
                }

                const [listeProduits] = await pool.query(sql, params);
                produits = listeProduits.map(p => ({
                    ...p,
                    disponible: p.disponibilite === 1
                }));
            }

            const [listeTypes] = await pool.query(
                "SELECT DISTINCT type FROM produits WHERE domaine = ?",
                [domaine]
            );
            types = listeTypes;
        } else {
            // Produits classiques pour pepiniere / maraichage / transformation
            let sql = "SELECT * FROM produits WHERE 1=1";
            let params = [];
            if (domaine) {
                sql += " AND domaine = ?";
                params.push(domaine);
            }
            if (type) {
                sql += " AND type = ?";
                params.push(type);
            }
            const [listeProduits] = await pool.query(sql, params);
            produits = listeProduits.map(p => ({ ...p, disponible: p.disponibilite === 1 }));

            // Sous-types
            const [listeTypes] = await pool.query("SELECT DISTINCT type FROM produits WHERE domaine = ?", [domaine]);
            types = listeTypes;
        }

        res.render("admin/catalogue", {
            categorie: domaine,
            produits,
            types,
            blog_articles,
            query_mode: mode,
            page_css: "blog_arbo.css"
        });

    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur serveur");
    }
});










// Actions au click sur les boutons


app.post('/upload-image', upload.single('image'), (req, res) => {
    try {
        const imageUrl = `/img/produits/${req.file.filename}`;
        res.json({ url: imageUrl });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Upload failed" });
    }
});




app.post("/admin/blog_arbo/ajouter", async (req, res) => {
    try {
        const { titre, redacteur, message } = req.body;
        await pool.query(
            "INSERT INTO blog_arbo (titre, redacteur, message, date_publi, shown) VALUES (?, ?, ?, NOW(), 1)",
            [titre, redacteur, message]
        );
        res.redirect("/admin/catalogue_produit?valeur=arboriculture");
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors de l'ajout de l'article");
    }
});



app.post('/admin/blog_arbo/supprimer/:id', async (req, res) => {
    const articleId = req.params.id;

    try {
        await pool.query("DELETE FROM blog_arbo WHERE id = ?", [articleId]);

        res.redirect('/admin/catalogue_produit?valeur=arboriculture&mode=blog');
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur suppression");
    }
});




app.post("/contact", async (req, res) => {

    const { prenom, nom, email, telephone, message } = req.body;

    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: "tonemail@gmail.com",
            pass: "motdepasseapplication"
        }
    });

    const mailOptions = {
        from: email,
        to: "emaildelaporteuse@gmail.com",
        subject: "Nouveau message depuis le site",
        text: `Prénom: ${prenom}Nom: ${nom} Email: ${email} Téléphone: ${telephone} 
        Message: ${message}
`
    };

    try {
        await transporter.sendMail(mailOptions);
        res.render("contact", { message: "Votre message a été envoyé !" });
    } catch (error) {
        console.log(error);
        res.send("Erreur lors de l'envoi");
    }
});



app.post("/connexion", async function (req, res) {
    // recup info de connexion
    let username = req.body.login;
    let password = req.body.mdp;
    let hashedPassword = crypto.createHash('md5').update(password).digest('hex');

    let result = await pool.query("SELECT * FROM utilisateur WHERE identifiant = ? AND mdp = ?", [username, hashedPassword])

    // verification info de l'utilisateur sont dans la bdd
    if (result[0].length > 0) {
        req.session.userRole = result[0][0].role;
        req.session.userID = result[0][0].id;
        req.session.prenom = result[0][0].prenom;
        if (req.session.userRole == "admin") {
            res.redirect("/admin/index");
        }
        else {
            res.redirect("/");
        }

    }

    else {
        res.render("connexion", { message: "Nom d'utilisateur ou mot de passe incorrect" });
    }
});

app.post("/deleteProduit/:id", async function(req, res){
    try {
        const id = req.params.id;
        console.log("ID à supprimer:", id); // DEBUG
        
        const suppression = await pool.query("DELETE FROM produit WHERE id = ?", [id]);
        console.log("Résultat suppression:", suppression[0]); // DEBUG
        
        res.redirect("/admin/liste_produits");
    }
    catch(err) {
        console.error("Erreur:", err);
        res.status(500).send("Erreur lors de la suppression du produit");
    }
});



app.post('/ajouter-produit', upload.single('image'), async function (req, res) {
    try {
        const { marque, modele, categorie, prix, description } = req.body;
        const image = req.file ? `/img/produits/${req.file.filename}` : null;
        await pool.query("INSERT INTO produit (type, description, marque, modele, prix_location, etat, image) VALUES (?, ?, ?, ?, ?, ?, ?)", [categorie, description, marque, modele, prix, 'très bon état', image]);

        res.redirect('/admin/ajout_produit');
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors de l'ajout du produit");
    }
});

app.post('/rechercher_suppression', async function (req, res) {
    try {
        const nomRecherche = '%' + req.body.search + '%';
        const produits_suppr = await pool.query("SELECT * FROM produit WHERE modele LIKE ? OR marque LIKE ?", [nomRecherche, nomRecherche]);
        res.render("gerant/ajout_suppr_produit", { produits_suppr: produits_suppr[0] });
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors de la recherche du produit");
    }
});


app.post('/supprimer-produit', async function (req, res) {
    try {
        const produitId = req.body.id;
        await pool.query("DELETE FROM produit WHERE id = ? AND NOT EXISTS (SELECT * FROM location WHERE produit_id = ?);", [produitId, produitId]);
        res.redirect('/gerant/ajout_suppr_produit');
    } catch (err) {
        console.error(err);
        res.status(500).send("Le produit est en réservation ou erreur lors de la suppression du produit");
    }
});

app.post('/supp-compte', async function (req, res) {
    try {
        const userId = req.session.userID;
        const result = await pool.query("DELETE FROM utilisateur WHERE id = ? AND type_utilisateur = 'client' AND NOT EXISTS (SELECT * FROM location WHERE utilisateur_id = ? );", [userId, userId]);
        if (result[0].length > 0) { //regarde si il y a un compte -- result[0] c'est ce qu'il y a dans la table
            req.session.destroy();
            res.redirect('/connexion');
        } else {
            res.status(400).send("Votre compte a des réservations en cours. Impossible de le supprimer.");
        }
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors de la suppression du compte");
    }
});

app.post('/inscription_infos', async function (req, res) {
    const nom = req.body.nom;
    const prenom = req.body.prenom;
    const tel = req.body.telephone;
    const age = req.body.ddn;
    const mail = req.body.mail;
    const mdp = req.body.mdp;
    const mdp_confirm = req.body.mdp_confirm;
    const conditions_générales = req.body.conditions_générales;
    const recevoir_mail = !!req.body.recevoir_mail;
    const login = req.body.login;

    const mailExistant = await pool.query("SELECT * FROM utilisateur WHERE email = ?", [mail]);
    const loginExistant = await pool.query("SELECT * FROM utilisateur WHERE login = ?", [login]);


    if (mailExistant[0].length > 0) {
        return res.render("inscription", { message: "Email déjà utilisé" });
    }
    else if (loginExistant[0].length > 0) {
        return res.render("inscription", { message: "Login déjà utilisé" });
    }

    else if (mdp == mdp_confirm) {
        const mdp_hash = crypto.createHash('md5').update(mdp).digest('hex')
        await pool.query("INSERT INTO utilisateur(login,password,nom,prenom,email,type_utilisateur, téléphone, age, newsletter) VALUES (?,?,?,?,?,?,?,?, ?)", [login, mdp_hash, nom, prenom, mail, 'client', tel, age, recevoir_mail]);
        res.redirect('/');
    } else {
        res.render("/inscription", { message: "Une information est erronée" });
    }
});

app.post('/modif_infos', async function (req, res) {
    try {
        const userId = req.session.userID;
        const currentUser = await pool.query("SELECT * FROM utilisateur WHERE id = ?", [userId]);
        const useractuel = currentUser[0]; 
        const { prenom, nom, ddn, email, password } = req.body;

        const updates = [];
        const values = [];

        if (prenom && prenom !== useractuel.prenom) { // le prenom && prenom évite de mettre à jour si le champ est vide
            updates.push('prenom = ?');
            values.push(prenom);
        }

        if (nom && nom !== useractuel.nom) {
            updates.push('nom = ?');
            values.push(nom);
        }

        if (ddn && ddn !== useractuel.ddn) {
            updates.push('ddn = ?');
            values.push(ddn);
        }

        if (email && email !== useractuel.email) {
            updates.push('email = ?');
            values.push(email);
        }


        if (password && password.trim() !== '') { //.trim() enlève les espaces
            let hashedPassword = crypto.createHash('md5').update(password).digest('hex');
            updates.push('password = ?');
            values.push(hashedPassword);
        }

        if (updates.length === 0) { // si aucun champ n'a été modifié
            return res.redirect('/co');
        }

        //modif info bdd
        values.push(userId);
        const requete = `UPDATE utilisateur SET ${updates.join(', ')} WHERE id = ?`;
        await pool.query(requete, values);

        //smodif info session
        if (prenom) req.session.userprenom = prenom;
        if (nom) req.session.usernom = nom;
        if (ddn) req.session.userddn = ddn;
        if (email) req.session.useremail = email;

        res.redirect('/co');

    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors de la modification du compte");
    }
});

app.post('/deco', async function (req, res) {

    req.session.destroy();
    res.redirect('/connexion');

});
















app.use((req, res) => {
    res.status(404).render("404");
})


app.listen(3000);