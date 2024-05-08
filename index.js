const express = require('express');
const path = require('path');
const cookieSession = require('cookie-session');
const bcrypt = require('bcrypt');
const dbconnection = require('./database');
const { body, validationResult } = require('express-validator');
const { response } = require('express');

const app = express();
app.use(express.urlencoded({extended:false}))

app.set('views',path.join(__dirname,'views')) // Corrected the spelling of 'views'
app.set('view engine','ejs');
app.use(cookieSession({
    name: 'session',
    keys:['key1','key2'],
    maxAge: 3600 * 1000
}))

const ifNotLoggedIn=(req,res,next) => {
    if(!req.session.isLoggedIn){
        return res.render('login');
    }
    next();
}

const ifLoggedIn=(req,res,next) => {
    if(req.session.isLoggedIn){
        return res.redirect('/home');
    }
    next();
}

// Root page
app.get('/', ifLoggedIn, (req, res) => {
    res.redirect('/login');
});

// Login page
app.get('/login', ifLoggedIn, (req, res) => {
    res.render('login');
});

app.post('/login', (req, res) => {
    const { username, password } = req.body;
    // Authenticate user from database
    dbconnection.query("SELECT * FROM users WHERE username = ?", [username], (err, results) => {
        if (err || results.length === 0) {
            return res.render('login', { error: 'Invalid username or password' });
        }
        const user = results[0];
        bcrypt.compare(password, user.password, (err, isMatch) => {
            if (err || !isMatch) {
                return res.render('login', { error: 'Invalid username or password' });
            }
            req.session.isLoggedIn = true;
            req.session.userID = user.id;
            res.redirect('/home');
        });
    });
});

// Registration page
app.get('/register', ifLoggedIn, (req, res) => {
    res.render('register');
});

app.post('/register', [
    body('username').trim().notEmpty().withMessage('Username is required'),
    body('password').trim().notEmpty().withMessage('Password is required')
], (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.render('register', { errors: errors.array() });
    }
    const { username, password } = req.body;
    bcrypt.hash(password, 10, (err, hash) => {
        if (err) {
            return res.render('register', { error: 'An error occurred' });
        }
        dbconnection.query("INSERT INTO users (username, password) VALUES (?, ?)", [username, hash], (err, result) => {
            if (err) {
                return res.render('register', { error: 'An error occurred' });
            }
            res.redirect('/login');
        });
    });
});

// Home page
app.get('/home', ifNotLoggedIn, (req, res) => {
    dbconnection.query("SELECT * FROM users WHERE id = ?", [req.session.userID], (err, results) => {
        if (err || results.length === 0) {
            return res.render('home', { name: 'User' });
        }
        const user = results[0];
        res.render('home', { name: user.name });
    });
});

app.listen(3000, () => console.log('Server is running on port 3000'));
