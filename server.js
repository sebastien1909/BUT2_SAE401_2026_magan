import express from "express";
import session from "express-session";
import crypto from "crypto";
import bodyParser from "body-parser";
import pool from "./db.js";
import multer from "multer";
import path from "path";


// Multer
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'public/img/produits'); // dossier de stockage des images
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
    res.render("index");
});

app.get("/logo-accueil", function(req,res){
    let role = req.session.userRole;
    if (role == "admin"){
        res.redirect("/admin/accueil");
    } else {
        res.redirect("/");
    }
})


app.get("/co", async function (req, res) {
    if (req.session.userRole) {
        let user = await pool.query("SELECT * FROM utilisateur WHERE id = ?", [req.session.userID]);

        if (user[0].length > 0) { // vérifie si l'utilisateur existe
            res.render("profil", {
                user: user[0][0]  // prends tout le tableau de l'utilisateur
            });
        } else {
            res.redirect("connexion");
        }
    }
    else {
        res.redirect("connexion");
    }
});

app.get("/presentation", async function (req, res) {
    res.render("presentation");
});


app.get('/produit/:id', async function (req, res) {
    const produitId = req.params.id;
    const row = await pool.query("SELECT * FROM produit WHERE id = ?", [produitId]);
    const produit = row[0][0]
    const type = produit.type
    const produit_plaire = await pool.query("SELECT * FROM produit WHERE type = ? AND id != ?LIMIT 3", [type, produitId]);
    res.render('produit', {
        produit: produit,
        produit_plaire: produit_plaire[0]
    })
});

app.get('/nutrition/:id', async function (req, res) {
    const produitId = req.params.id;
    const row = await pool.query("SELECT * FROM produit WHERE id = ?", [produitId]);
    const produit = row[0][0]
    const type = produit.type
    const produit_plaire = await pool.query("SELECT * FROM produit WHERE type = ? AND id != ?LIMIT 3", [type, produitId]);
    res.render('nutrition', {
        produit: produit,
        produit_plaire: produit_plaire[0]
    })
});

app.get('/appareils_equipements/:id', async function (req, res) {
    const produitId = req.params.id;
    const row = await pool.query("SELECT * FROM produit WHERE id = ?", [produitId]);
    const produit = row[0][0]
    const type = produit.type
    const produit_plaire = await pool.query("SELECT * FROM produit WHERE type = ? AND id != ?LIMIT 3", [type, produitId]);
    res.render('appareils_equipements', {
        produit: produit,
        produit_plaire: produit_plaire[0]
    })
});




app.get("/catalogue_produit", async function (req, res) {
    const tri = req.query.tri;
    const ordre = req.query.ordre === 'desc' ? 'DESC' : 'ASC';
    const filtre = req.query.filtre;
    const valeur = req.query.valeur;

    let RequetedeBase = "SELECT * FROM produit";
    let queryParams = [];

    if (filtre && valeur) {
        RequetedeBase += ` WHERE ${filtre} = ?`;
        queryParams.push(valeur);
    }

    if (tri) {
        RequetedeBase += ` ORDER BY ${tri} ${ordre}`;
    }

    try {
        const result = await pool.query(RequetedeBase, queryParams);
            
        res.render("catalogue_produit", { liste_produits: result[0] });
    } catch (error) {
        console.error("Erreur SQL :", error);
        res.status(500).send("Erreur serveur");
    }
});



app.get("/connexion", function (req, res) {
    res.render("connexion", { variable: "aled" });
});






app.get("/inscription", function (req, res) {
    res.render("inscription", { variable: "aled" });
});

app.get("/catalogue_categorie", async function (req, res) {
    // Récupérer les catégories uniques
    const typesResult = await pool.query("SELECT DISTINCT type FROM produit");
    const types = typesResult[0].map(row => row.type);
    
    // Pour chaque catégorie, récupérer les produits
    const categories = [];
    for (let type of types) {
        const produitsResult = await pool.query("SELECT * FROM produit WHERE type = ?", [type]);
        categories.push({
            type: type,
            count: produitsResult[0].length,
            produits: produitsResult[0]
        });
    }
    
    res.render("catalogue_categorie", { categories: categories });
});





// partie pour le gerant

app.get("/gerant/accueil", async function (req, res) {
    let produits_aime = await pool.query("SELECT * FROM produit ORDER BY note DESC LIMIT 5;");
    res.render("gerant/accueil", {
        produits_aime: produits_aime[0],
        prenom: req.session.nom
    });
});

app.get("/gerant/ajout_suppr_produit", async function (req, res) {
    const liste_produit = await pool.query("SELECT * FROM produit");
    res.render("gerant/ajout_suppr_produit", { produits_suppr: liste_produit[0] });
});

app.get("/gerant/check_reservation", function (req, res) {
    res.render("gerant/check_reservation", { variable: "aled" });
});

app.get("/gerant/liste_reservation", async function (req, res) {
    const liste_reservation = await pool.query("SELECT produit.description, produit.marque, produit.modele, produit.image, location.date_debut, location.date_retour_prevue, location.id, location.prix_total, location.date_retour_effective, utilisateur.login, utilisateur.email FROM produit NATURAL JOIN location LEFT JOIN utilisateur ON (utilisateur.id = location.utilisateur_id)")
    const resa_unfinished = await pool.query("SELECT produit.description, produit.marque, produit.modele, produit.image, location.date_debut, location.date_retour_prevue, location.id, location.prix_total, location.date_retour_effective, utilisateur.login, utilisateur.email FROM location JOIN utilisateur ON (utilisateur.id = location.utilisateur_id) JOIN produit ON (produit.id = location.produit_id) WHERE location.date_retour_effective IS NULL")
    res.render("gerant/liste_resa", { liste_resa: liste_reservation[0], resa_pas_finis:resa_unfinished[0] });
});

app.get("/gerant/nouveaute", function (req, res) {
    res.render("gerant/nouveaute", { variable: "aled" });
});

app.get("/gerant/catalogue_produit", async function (req, res) {
    const tri = req.query.tri;
    const ordre = req.query.ordre === 'desc' ? 'DESC' : 'ASC';
    const filtre = req.query.filtre;
    const valeur = req.query.valeur;

    let RequetedeBase = "SELECT * FROM produit";
    let queryParams = [];

    if (filtre && valeur) {
        RequetedeBase += ` WHERE ${filtre} = ?`;
        queryParams.push(valeur);
    }

    // Ajout du tri si demandé
    if (tri) {
        RequetedeBase += ` ORDER BY ${tri} ${ordre}`;
    }

    try {
        const result = await pool.query(RequetedeBase, queryParams);
        res.render("gerant/catalogue_produit", { liste_produits: result[0] });
    } catch (error) {
        console.error("Erreur SQL :", error);
        res.status(500).send("Erreur serveur");
    }
});


app.get('/gerant/produit/:id', async function (req, res) {
    const produitId = req.params.id;
    const row = await pool.query("SELECT * FROM produit WHERE id = ?", [produitId]);
    const produit = row[0][0]
    const type = produit.type
    const produit_plaire = await pool.query("SELECT * FROM produit WHERE type = ? AND id != ? LIMIT 3", [type, produitId]);
    res.render('gerant/produit', {
        produit: produit,
        produit_plaire: produit_plaire[0]
    })
});

app.get('/gerant/reservation/:id', async function (req, res) {
    const produitId = req.params.id;
    const row = await pool.query("SELECT * FROM produit WHERE id = ?", [produitId]);
    const produit = row[0][0]
    const type = produit.type
    const produit_plaire = await pool.query("SELECT * FROM produit WHERE type = ? AND id != ? LIMIT 3", [type, produitId]);
    res.render('gerant/reservation', {
        produit: produit
    })
});




app.get('/admin/accueil', async function (req, res) {

    let produits_aime = await pool.query("SELECT * FROM produit LIMIT 5");
    res.render("admin/accueil", {
        produits_aime: produits_aime[0],
        prenom: req.session.nom
    });
});

app.get('/liste_gerant', async function (req,res){
    const liste_gerant = await pool.query("SELECT * FROM utilisateur WHERE type_utilisateur LIKE 'agent'")
    res.render("admin/liste_gerants", {gerants:liste_gerant[0]})
})


app.get('/admin/ajout_agent', async function (req,res){
    const liste_gerant = await pool.query("SELECT * FROM utilisateur WHERE type_utilisateur LIKE 'agent'")
    res.render("admin/ajout_agent", {gerants:liste_gerant[0]})
})











// Actions au click sur les boutons


app.post("/connexion", async function (req, res) {
    // recup info de connexion
    let username = req.body.login;
    let password = req.body.mdp;
    let hashedPassword = crypto.createHash('md5').update(password).digest('hex');

    let result = await pool.query("SELECT * FROM utilisateur WHERE login = ? AND password = ?", [username, hashedPassword])

    // verification info de l'utilisateur sont dans la bdd
    if (result[0].length > 0) {
        req.session.userRole = result[0][0].type_utilisateur;
        req.session.userID = result[0][0].id;
        req.session.prenom = result[0][0].prenom;
        if (req.session.userRole == "agent") {
            res.redirect("/gerant/accueil");
        }
        else if (req.session.userRole == "admin") {
            res.redirect("/admin/accueil");
        }
        else {
            res.redirect("/");
        }

    }
    //si c'est le cas : on recup le rôle + on initialise une session + redirection page accueil
    else {
        res.render("connexion", { message: "Nom d'utilisateur ou mot de passe incorrect" });
    }
    //sinon : message d'erreur + redirection page connexion
});

app.post("/deleteReservation/:id", async function(req, res){
    try {
        const id = req.params.id;
        console.log("ID à supprimer:", id); // DEBUG
        
        const suppression = await pool.query("DELETE FROM location WHERE id = ?", [id]);
        console.log("Résultat suppression:", suppression[0]); // DEBUG
        
        res.redirect("/gerant/liste_reservation");
    }
    catch(err) {
        console.error("Erreur:", err);
        res.status(500).send("Erreur lors de la suppression de la réservation");
    }
});


app.post("/ajouter-agent", async function (req, res){
    try{
        const { username, nom, prenom, ddn, mdp, mail } = req.body;
        
        
        const loginExistant = await pool.query("SELECT * FROM utilisateur WHERE login = ?", [username]);
        const mailExistant = await pool.query("SELECT * FROM utilisateur WHERE email = ?", [mail]);
        
        if (loginExistant[0].length > 0) {
            return res.status(400).send("Ce nom d'utilisateur existe déjà");
        }
        
        if (mailExistant[0].length > 0) {
            return res.status(400).send("Cet email est déjà utilisé");
        }
        
        const mdp_hash = crypto.createHash('md5').update(mdp).digest('hex');
        
        await pool.query("INSERT INTO utilisateur (login, password, nom, prenom, ddn, email, type_utilisateur) VALUES (?, ?, ?, ?, ?, ?, 'agent')", [username, mdp_hash, nom, prenom, ddn, mail]);
        
        console.log("Agent ajouté avec succès");
        res.redirect('/admin/ajout_agent');
        
    } catch(err){
        console.error("Erreur complète:", err);
        res.status(500).send(`Erreur lors de l'ajout de l'agent: ${err.message}`);
    }
});


app.post('/ajouter-produit', upload.single('image'), async function (req, res) {
    try {
        const { marque, modele, categorie, prix, description } = req.body;
        const image = req.file ? `/img/produits/${req.file.filename}` : null;
        await pool.query("INSERT INTO produit (type, description, marque, modele, prix_location, etat, image) VALUES (?, ?, ?, ?, ?, ?, ?)", [categorie, description, marque, modele, prix, 'très bon état', image]);

        res.redirect('/gerant/ajout_suppr_produit');
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
























// TESTS //








app.post("/reservation", async function (req, res) {
    try {
        const produitId = req.body.produit_id;
        const quantite = req.body.quantite || 1;
        const date_debut = req.body.date_debut;
        const date_fin = req.body.date_fin;
        
        if (!req.session.userID) {
            return res.redirect("/connexion");
        }

        // Vérifier si le produit existe
        const produit = await pool.query("SELECT * FROM produit WHERE id = ?", [produitId]);
        if (produit[0].length === 0) {
            return res.status(404).send("Produit non trouvé");
        }

        // Ajouter au panier
        await pool.query(
            "INSERT INTO panier (id_utilisateur, id_produit) VALUES (?, ?)",
            [req.session.userID, produitId]
        );

        // Stocker les dates en session pour la page paiement
        if (!req.session.panier_temp) {
            req.session.panier_temp = {};
        }
        req.session.panier_temp[produitId] = {
            quantite: quantite,
            date_debut: date_debut,
            date_fin: date_fin,
            prix: produit[0][0].prix_location * quantite
        };

        res.redirect("/panier");
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors de l'ajout au panier");
    }
});




app.get("/panier", async function (req, res) {
    try {
        if (!req.session.userID) {
            return res.redirect("/connexion");
        }

        const panier = await pool.query(
            `SELECT panier.id, panier.id_produit, produit.marque, produit.modele, 
             produit.image, produit.prix_location, produit.description
             FROM panier 
             JOIN produit ON panier.id_produit = produit.id 
             WHERE panier.id_utilisateur = ?`,
            [req.session.userID]
        );

        // Calculer le total
        let total = 0;
        const panierAvecDetails = panier[0].map(item => {
            const details = req.session.panier_temp?.[item.id_produit] || {
                quantite: 1,
                date_debut: null,
                date_fin: null
            };
            
            // Calculer les jours de location
            let jours = 1;
            if (details.date_debut && details.date_fin) {
                const debut = new Date(details.date_debut);
                const fin = new Date(details.date_fin);
                jours = Math.ceil((fin - debut) / (1000 * 60 * 60 * 24)) || 1;
            }
            
            const prix_total = item.prix_location * jours * details.quantite;
            total += prix_total;

            return {
                ...item,
                ...details,
                jours: jours,
                prix_total: prix_total
            };
        });

        res.render("panier", { 
            panier: panierAvecDetails,
            total: total.toFixed(2)
        });
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors de l'affichage du panier");
    }
});




app.post("/panier/supprimer/:id", async function (req, res) {
    try {
        const panierId = req.params.id;
        
        // Récupérer l'id_produit avant suppression
        const item = await pool.query("SELECT id_produit FROM panier WHERE id = ?", [panierId]);
        
        if (item[0].length > 0) {
            const produitId = item[0][0].id_produit;
            
            // Supprimer du panier
            await pool.query("DELETE FROM panier WHERE id = ? AND id_utilisateur = ?", 
                [panierId, req.session.userID]);
            
            // Supprimer des données temporaires
            if (req.session.panier_temp && req.session.panier_temp[produitId]) {
                delete req.session.panier_temp[produitId];
            }
        }

        res.redirect("/panier");
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors de la suppression");
    }
});



app.get("/paiement", async function (req, res) {
    try {
        if (!req.session.userID) {
            return res.redirect("/connexion");
        }

        // Récupérer les produits du panier
        const panier = await pool.query(
            `SELECT panier.id, panier.id_produit, produit.marque, produit.modele, 
             produit.image, produit.prix_location, produit.description
             FROM panier 
             JOIN produit ON panier.id_produit = produit.id 
             WHERE panier.id_utilisateur = ?`,
            [req.session.userID]
        );

        if (panier[0].length === 0) {
            return res.redirect("/panier");
        }

        // Calculer le total
        let total = 0;
        const produitsAvecDetails = panier[0].map(item => {
            const details = req.session.panier_temp?.[item.id_produit] || {
                quantite: 1,
                date_debut: null,
                date_fin: null
            };
            
            let jours = 1;
            if (details.date_debut && details.date_fin) {
                const debut = new Date(details.date_debut);
                const fin = new Date(details.date_fin);
                jours = Math.ceil((fin - debut) / (1000 * 60 * 60 * 24)) || 1;
            }
            
            const prix_total = item.prix_location * jours * details.quantite;
            total += prix_total;

            return {
                ...item,
                ...details,
                jours: jours,
                prix_total: prix_total
            };
        });

        // Récupérer les infos utilisateur
        const user = await pool.query("SELECT * FROM utilisateur WHERE id = ?", [req.session.userID]);

        res.render("paiement", { 
            produits: produitsAvecDetails,
            total: total.toFixed(2),
            user: user[0][0]
        });
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors de l'affichage du paiement");
    }
});




app.post("/paiement", async function (req, res) {
    try {
        if (!req.session.userID) {
            return res.redirect("/connexion");
        }

        const { cardname, cardnumber, exp, cvv, nom, prenom, address, address2, city, codepostal } = req.body;

        // Récupérer les produits du panier
        const panier = await pool.query(
            "SELECT * FROM panier WHERE id_utilisateur = ?",
            [req.session.userID]
        );

        if (panier[0].length === 0) {
            return res.redirect("/panier");
        }

        // Créer les locations pour chaque produit
        for (let item of panier[0]) {
            const details = req.session.panier_temp?.[item.id_produit] || {};
            
            let jours = 1;
            if (details.date_debut && details.date_fin) {
                const debut = new Date(details.date_debut);
                const fin = new Date(details.date_fin);
                jours = Math.ceil((fin - debut) / (1000 * 60 * 60 * 24)) || 1;
            }

            // Récupérer le prix du produit
            const produit = await pool.query("SELECT prix_location FROM produit WHERE id = ?", [item.id_produit]);
            const prix_total = produit[0][0].prix_location * jours * (details.quantite || 1);

            // Insérer dans la table location
            await pool.query(
                `INSERT INTO location (date_debut, date_retour_prevue, prix_total, utilisateur_id, produit_id) 
                 VALUES (?, ?, ?, ?, ?)`,
                [
                    details.date_debut || new Date(),
                    details.date_fin || new Date(),
                    prix_total,
                    req.session.userID,
                    item.id_produit
                ]
            );
        }

        // Vider le panier
        await pool.query("DELETE FROM panier WHERE id_utilisateur = ?", [req.session.userID]);
        
        // Nettoyer les données temporaires
        delete req.session.panier_temp;

        // Rediriger vers une page de confirmation
        res.redirect("/confirmation-paiement");
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur lors du paiement");
    }
});



app.get("/confirmation-paiement", function (req, res) {
    res.render("confirmation", { 
        message: "Votre paiement a été effectué avec succès !" 
    });
});

























app.use((req, res) => {
    res.status(404).render("404");
})


app.listen(3000);