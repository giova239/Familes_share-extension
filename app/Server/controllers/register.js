const bcrypt = require("bcrypt");

const client = require("../configs/database.js");

const emailvalidator = require("email-validator");

const passwordValidator = require('password-validator');

//Registration Function
exports.register = async (req, res) => {
    const {name, surname, email, password, birth_date, phone, id_user} = req.body;
    try {
        const data = await client.query(`SELECT * FROM "Users" WHERE email= $1;`, [email]); //Checking if user already exists
        const arr = data.rows;
        var pwdValidator = new passwordValidator();

        pwdValidator
            .is().min(8)
            .is().max(100)
            .has().uppercase()
            .has().lowercase();

        if(emailvalidator.validate(email)){
            if(pwdValidator.validate(password)){
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
                            id_user,
                            name,
                            surname,
                            email,
                            password: hash,
                            birth_date,
                            phone
                        };
                        //Inserting data into the database
                        
                        client.query(`INSERT INTO "Users" (name, surname, email, password, birth_date, phone) VALUES ($1,$2,$3,$4,$5,$6);`, [user.name, user.surname, user.email, user.password, user.birth_date, user.phone], (err) => {
                            if (err) {
                                console.error(err);
                                return res.status(500).json({
                                    error: "Database error"
                                })
                            }
                            else {
                                res.status(200).send({
                                    message: 'User added to database, not verified',
                                    id_user: id_user,
                                });
                            }
                        })
                        
                    });
                }
            }else{
                res.status(400).json({
                    error: 'Invalid Password'
                });
            }
        }else{
            res.status(400).json({
                error: 'Invalid Email'
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