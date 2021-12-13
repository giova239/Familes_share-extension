const client = require('./connection.js')
const express = require('express');
const path = require('path');
const multer = require('multer');

const app = express();

app.listen(3300, ()=>{
    console.log("Sever is now listening at port 3300");
})

client.connect();

const imageStorage = multer.diskStorage({
    // Destination to store image     
    destination: 'images', 
        filename: (req, file, cb) => {
            cb(null, file.fieldname + '_' + Date.now() 
             + path.extname(file.originalname))
        }
});

const imageUpload = multer({
    storage: imageStorage,
    fileFilter(req, file, cb) {
        if (!file.originalname.match(/\.(png|jpg)$/)) { 
            // upload only png and jpg format
            return cb(new Error('Please upload a Image'))
        }
        cb(undefined, true)
    }
}) 

app.post('/uploadimage/:id', imageUpload.single('image'), (req, res) => {
    console.log(req.file.path);

    let insertQuery = `insert into "Images"(id_image, id_announcement)
                         values ('${req.file.path}', ${req.params.id})`;

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
    client.query(`Select * from "AnnouncementsGroups" natural join "Announcements" where id_group=${req.params.id}`, (err, result)=>{
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
    client.query(`Select * from "UsersGroups","Groups" where id_user=${req.params.id} and "UsersGroups".id_group = "Groups".id_group`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

app.get('/users/:id', (req, res)=>{
    client.query(`Select *, to_char(birth_date, 'DD-MON-YYYY') as birth_date from "Users" where id_user=${req.params.id}`, (err, result)=>{
        if(!err){
            res.send(result.rows);
        }
    });
    client.end;
})

app.get('/chat/:id', (req, res)=>{
    client.query(`Select * from "Chats" where id_chat=${req.params.id}`, (err, result)=>{
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
                        values(${user.id_user}, '${user.username}', '${user.name}', '${user.surname}', '${user.password}', '${user.birth_date}', '${user.email}',  '${user.phone}', '${user.street}', '${user.city}', '${user.postal_code}')`

    client.query(insertQuery, (err, result)=>{
        if(!err){
            res.send('Insertion was successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
})

function insertAnnGroup(new_id, id_group){
    let insertNew_id = `insert into "AnnouncementsGroups"(id_announcement, id_group) 
                        values(${new_id}, ${id_group})`
    
    client.query(insertNew_id, (err, result)=>{
        if(!err){
            console.log("Insertion AnnouncementGroup successful")
        }
        else{ console.log(err.message) }
    })
    client.end;     
}

app.post('/createAnnouncement/:id', (req, res)=> { 
    const announcement = req.body;
    let insertQuery = `insert into "Announcements"(title, description, type, creator) 
                        values('${announcement.title}', '${announcement.description}', '${announcement.type}', ${req.params.id})
                        RETURNING id_announcement;`

    client.query(insertQuery, (err, result)=>{
        if(!err){
            insertAnnGroup(result.rows[0].id_announcement, announcement.id_group);
            res.send('Insertion Announcement successful')
        }
        else{ console.log(err.message) }
    })
    client.end;
               
})

app.post('/groups', (req, res)=> { 
    const group = req.body;
    let insertQuery = `insert into "Groups"(id_group, name, description) 
                        values(${group.id_group}, '${group.name}', '${group.description}')`

    client.query(insertQuery, (err, result)=>{
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
                        values(${usergroup.id_user}, ${usergroup.id_group})`

    client.query(insertQuery, (err, result)=>{
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

