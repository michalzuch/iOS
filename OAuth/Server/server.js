const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

const users = {};

const userData = {
    username: 'test', password: 'test', name: 'Name Surname', google: undefined, github: undefined
};

users['test@test.com'] = userData

app.post('/signup', (req, res) => {
    const {email, password, name, username} = req.body;

    if (users[email]) {
        return res.status(400).json({message: 'User already exists'});
    }

    users[email] = {
        username: username, password: password, name: name, google: undefined, github: undefined
    };

    res.status(200).json({message: 'User signed up successfully'});
});

app.post('/login', (req, res) => {
    const {email, password} = req.body;

    if (!users[email] || users[email].password !== password) {
        return res.status(400).json({message: 'Invalid username or password'});
    }

    res.status(200).json({message: 'User logged in successfully'});
});

app.post('/google', (req, res) => {
    const {email, name, token} = req.body;
    let username = email.split('@')[0]

    if (email in users && users[email].google !== undefined) {
        res.status(200).json({message: 'User logged in successfully'});
        return
    }

    users[email] = {
        username: username, password: undefined, name: name, google: token, github: undefined
    };

    res.status(200).json({message: 'User signed up successfully'});
});

app.post('/github', (req, res) => {
    const {email, name, token} = req.body;
    let username = Math.random().toString(36).substring(2, 12);

    if (username in users && users[username].github !== undefined) {
        res.status(200).json({message: 'User logged in successfully'});
        return
    }

    users[username] = {
        username: username, password: undefined, name: name, google: undefined, github: token
    };

    res.status(200).json({message: 'User signed up successfully'});
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
