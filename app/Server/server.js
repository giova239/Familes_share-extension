const express = require("express");

const app = express(); //Initialized express

var cors= require("cors");

app.use(express.json());
app.use(cors());

const port = process.env.PORT || 3300;

app.get("/", (req, res) => {
    res.status(200).send("Engine Started, Ready to take off!");
})

app.listen(port, () => {
    console.log(`Here we go, Engines started at ${port}.`);
})

require("./configs/dotenv")

require("dotenv").config();

const client = require("./configs/database");

client.connect((err) => { //Connected Database
    if (err) { console.log(err);}
    else {console.log("Data logging initiated!");}
});

const  user  =  require("./routes/users");

app.use("/user",  user);  //Route for /user endpoint of API


//---------------------------------------QUERY CHE ANDRANNO POI SPOSTATE IN UN'ALTRA CARTELLA----------------------------------------//
const path = require('path');
const multer = require('multer');
const fs = require('fs');

const imageStorage = multer.diskStorage({
    // Destination to store image     
    destination: 'images', 
    filename: (req, file, cb) => {
        cb(null, req.body.id_announcement+ '_' + file.fieldname + '_' + Date.now() + path.extname(file.originalname))
    }
});

const imageUpload = multer({
    storage: imageStorage,
    fileFilter(req, file, cb) {
        if (!file.originalname.match(/\.(png|jpg|jpeg|PNG|JPG|JPEG)$/)) { 
            // upload only png and jpg format
            return cb(new Error('Please upload a Image'))
        }
        cb(undefined, true)
    }
}) 

app.post('/uploadimage', imageUpload.single('image'), (req, res) => {
    console.log("UPLOADING IMAGE #" + req.body.id_announcement + " AT PATH: " + req.file.path);

    let insertQuery = `insert into "Images"(image_path, id_announcement)
                         values ('${req.file.path}', ${req.body.id_announcement.split("_")[0]})`;

    client.query(insertQuery, (err, result)=>{
        if(!err){
            res.send('Insertion was successful')
        }
        else{ console.log(err.message) }
        })
    client.end;   

}, (error, req, res, next) => {
    res.status(400).send({ error: error.message })
})



app.get("/getImage/:id", (req, res)=>{ //get first image of the announcement
   client.query(`Select "Images".image_path from "Images" where "Images".id_announcement=$1 FETCH FIRST ROW ONLY`, [req.params.id] ,(err, result)=>{

       if(!err && result.rows[0]){
          fs.readFile(result.rows[0].image_path, function (err, data) {
            if (!err){
                res.send(data);
            }
          });
       }
   });
   client.end;
})

app.get("/getImageByIndex/:id/:index", (req, res)=>{ //get first image of the announcement
    client.query(`Select "Images".image_path from "Images" where "Images".id_announcement=$1 `,[req.params.id], (err, result)=>{

        if(!err && result.rows[req.params.index-1]){
            fs.readFile(result.rows[req.params.index-1].image_path, function (err, data) {
                if (!err){
                    res.send(data);
                    console.log("SENT IMAGE #" + req.params.index + " of ANNOUNCEMENT" + req.params.id);
                }
            });
        }
    });
    client.end;
 })

 app.get('/getImageCount/:id', (req, res)=>{
    client.query(`SELECT COUNT(*) AS ammount FROM "Images" where id_announcement=$1`, [req.params.id], (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

app.get('/users', (req, res)=>{
    client.query(`Select *, to_char(birth_date, 'DD-MON-YYYY') as birth_date from "Users"`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

app.get('/groups', (req, res)=>{
    client.query(`Select * from "Groups"`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

app.get('/announcementListForGroup/:id', (req, res)=>{
    client.query(`Select * from "AnnouncementsGroups" natural join "Announcements" join "Users" on "Users".id_user = "Announcements".creator where id_group=$1 `,[req.params.id], (err, result)=>{
        if(!err){
            res.send(result.rows);
        }else{
            console.log("errore");
        }
    });
    client.end;
})

app.get('/announcements', (req, res)=>{
    client.query(`Select * from "Announcements"`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

app.get('/usersgroups', (req, res)=>{
    client.query(`Select * from "UsersGroups"`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

app.get('/usergroups/:id', (req, res)=>{
    client.query(`Select * from "UsersGroups","Groups" where id_user=$1 and "UsersGroups".id_group = "Groups".id_group`, [req.params.id] ,(err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

app.get('/users/:id', (req, res)=>{
    client.query(`Select *, to_char(birth_date, 'DD-MON-YYYY') as birth_date from "Users" where id_user=$1`, [req.params.id], (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

app.get('/notifications/:id', (req, res)=>{
    client.query(`Select * from "Chats" where id_chat=$1`, [req.params.id],(err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

const bodyParser = require("body-parser");
const { Pool, _pools } = require('pg/lib');
const { rows } = require('pg/lib/defaults');
app.use(bodyParser.json());

app.post('/users', (req, res)=> { //Richieste post bisogna farle con postman
    const user = req.body;
    let insertQuery = `insert into "Users"(id_user, username, name, surname, password, birth_date, email, phone, street, city, postal_code)
                        values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)`

    client.query(insertQuery,[user.id_user, user.username, user.name, user.surname, user.password, user.birth_date, user.email, user.phone, user.street, user.city, user.postal_code], (err, result)=>{
        if(!err){
            res.send('Insertion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

function insertAnnGroup(new_id, id_group){
    let insertNew_id = `insert into "AnnouncementsGroups"(id_announcement, id_group)
                        values($1, $2)`

    client.query(insertNew_id,[new_id, id_group] ,(err, result)=>{
        if(err){ console.log(err.message) }
    })
    client.end;
}

app.post('/createAnnouncement/:id', (req, res)=> {
    const announcement = req.body;
    let insertQuery = `insert into "Announcements"(title, description, type, creator)
                        values($1, $2, $3, $4)
                        RETURNING id_announcement;`

    client.query(insertQuery, [announcement.title,announcement.description, announcement.type, req.params.id], (err, result)=>{
        if(!err){
            insertAnnGroup(result.rows[0].id_announcement, announcement.id_group);
            res.send(result.rows[0])
        }
        else{ console.log(err.message) }
    })
    client.end;

})

app.post('/groups', (req, res)=> {
    const group = req.body;
    let insertQuery = `insert into "Groups"(id_group, name, description)
                        values($1, $2, $3)`

    client.query(insertQuery,[group.id_group, group.name, group.description] , (err, result)=>{
        if(!err){
            res.send('Insertion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

app.post('/usersgroups', (req, res)=> {
    const usergroup = req.body;
    let insertQuery = `insert into "UsersGroups"(id_user, id_group)
                        values($1, $2)`

    client.query(insertQuery, [usergroup.id_user, usergroup.id_group] ,(err, result)=>{
        if(!err){
            res.send('Insertion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

app.post('/users/column', (req, res)=> { //Query per aggiungere colonna, editabile di volta in volta
    client.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS Email varchar(255)', (err, result)=>{
        if(!err){
            res.send('Column added successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

app.get('/allGroups', (req, res)=>{
    client.query(`Select * from "Groups"`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

function insertUserGroup(id_user, id_group){
    let insertNew_id = `insert into "UsersGroups"(id_user, id_group)
                        values($1, $2)`

    client.query(insertNew_id, [id_user, id_group],(err, result)=>{
        if(err){ console.log(err.message) }
    })
    client.end;
}

app.post('/createGroup/:id', (req, res)=> {
    const group= req.body;
    let insertQuery = `insert into "Groups"(name, description)
                        values( $1 , $2 )
                        RETURNING id_group;`

    let id_user= `${req.params.id}`
    client.query(insertQuery, [group.name, group.description] , (err, result)=>{
        if(!err){
            insertUserGroup(id_user, result.rows[0].id_group);
            res.send(result.rows[0])
        }
        else{ console.log(err.message) }
    })
    client.end;
})

app.post('/joinGroup', (req, res)=> {
    const usergroup = req.body;
    let insertQuery = `insert into "UsersGroups"(id_user, id_group)
                        values($1, $2)`

    client.query(insertQuery, [usergroup.user_id, usergroup.group_id], (err, result)=>{
        if(!err){
            res.send('Insertion was successful');
        }
        else{ console.log(err.message) }
    })
    client.end;
})


app.post('/createChat', (req, res)=> {
    const user = req.body;

    if(user.user1 === user.user2){
        res.status(400).json({
            message: "Non puoi scrivere a te stesso!",
        });
    }else{
        let insertQuery = `Select id_chat from "Chats" where ("Chats".user1 = $1 and "Chats".user2 = $2) or ("Chats".user1 = $2 and "Chats".user2 = $1)`

        client.query(insertQuery, [user.user1, user.user2], (err, rows,result)=>{
            if(!err){
                if(!rows.rows[0]){
                    let insertQuery2 = `insert into "Chats"(user1, user2)
                                       values($1, $2)
                                       RETURNING id_chat`;

                    client.query(insertQuery2, [user.user1, user.user2], (err, result)=>{
                        if(!err){
                            res.status(200).json({
                                message: "Insertion was successful",
                                id_chat: result.rows[0].id_chat,
                            });
                        }
                        else{ console.log(err.message) }
                    })
                    client.end;
                }else{
                    res.status(200).json({
                        message: "Utenti già presenti",
                        id_chat: rows.rows[0].id_chat,
                    });
                }
            }else{ console.log(err.message) }
        })
        client.end;
    }
})

app.get('/getUserChats/:id', (req, res)=> {
    const user = req.params;
    let insertQuery = `Select * from "Chats" join "Users" on "Chats".user1 = "Users".id_user where "Chats".user2=$1
                       UNION
                       Select * from "Chats" join "Users" on "Chats".user2 = "Users".id_user where "Chats".user1=$1 `

    client.query(insertQuery, [user.id] , (err, result)=>{
        if(!err){
            res.send(result.rows)
        }
        else{ console.log(err.message) }
    })
    client.end;
})

app.get('/getAllMessages/:id', (req, res)=> {
    const message = req.params;
    let insertQuery = `Select * from "Messages" where "Messages".chat=$1 ORDER BY date_time`

    client.query(insertQuery, [message.id] , (err, result)=>{
        if(!err){
            res.send(result.rows)
        }
        else{ console.log(err.message) }
    })
    client.end;
})

app.post('/sendMessage', (req, res)=> {
    const message = req.body;
    let insertQuery = `insert into "Messages"(text, chat, sender, date_time)
                       values($1, $2, $3, $4)`

    var datetime= new Date();

    client.query(insertQuery, [message.text, message.chat, message.sender, datetime] , (err, result)=>{
        if(!err){
            res.send("Insertion was successful");
        }
        else{ console.log(err.message) }
    })
    client.end;
})











