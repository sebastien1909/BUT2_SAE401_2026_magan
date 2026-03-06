import mysql from "mysql2/promise";

// CrÃ©e un pool de connexions
const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "",
  database: "Magan",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

export default pool;