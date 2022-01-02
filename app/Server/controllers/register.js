const bcrypt = require("bcrypt");

const client = require("../configs/database.js");

const jwt = require("jsonwebtoken");

//Registration Function
exports.register = async (req, res) => {
    const {name, surname, email, password, birth_date, phone} = req.body;
    try {
        const data = await client.query(`SELECT * FROM "Users" WHERE email= $1;`, [email]); //Checking if user already exists
        const arr = data.rows;
        console.log("ok");
        if (arr.length != 0) {
            return res.status(400).json({
                error: "Email already there, No need to register again.",
            });
        }
        else {
            bcrypt.hash(password, 10, (err, hash) => {
                if (err)
                    res.status(err).json({
                        error: "Server error",
                    });
                const user = {
                    name,
                    surname,
                    email,
                    password: hash,
                    birth_date,
                    phone
                };
                var flag = 1; //Declaring a flag

                //Inserting data into the database
                client.query(`INSERT INTO "Users" (name, surname, email, password, birth_date, phone) VALUES ($1,$2,$3,$4,$5,$6);`, [user.name, user.surname, user.email, user.password, user.birth_date, user.phone], (err) => {

                    if (err) {
                        flag = 0; //If user is not inserted is not inserted to database assigning flag as 0/false.
                        console.error(err);
                        return res.status(500).json({
                            error: "Database error"
                        })
                    }
                    else {
                        flag = 1;
                        res.status(200).send({ message: 'User added to database, not verified' });
                    }
                })
                if (flag) {
                    const token = jwt.sign( //Signing a jwt token
                        {
                            email: user.email
                        },
                        process.env.SECRET_KEY
                    );
                };
            });
        }
    }
    catch (err) {
        console.log(err);
        res.status(500).json({
            error: "Database error while registring user!", //Database connection error
        });
    };
}
