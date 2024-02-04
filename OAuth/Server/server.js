const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

const users = {};

const userData = {
    email: 'test@test.com', password: 'test', name: 'Name Surname', oauth: {
        google: {
            accessToken: undefined, refreshToken: undefined
        }, github: {
            accessToken: undefined, refreshToken: undefined
        }
    }
};

users['unique_username'] = userData

app.post('/signup', (req, res) => {
    const {email, password, name, username} = req.body;

    if (users[username]) {
        return res.status(400).json({message: 'User already exists'});
    }

    users[username] = {
        email: email, password: password, name: name, oauth: {}
    };

    res.status(200).json({message: 'User signed up successfully'});
});

app.post('/login', (req, res) => {
    const {username, password} = req.body;

    if (!users[username] || users[username].password !== password) {
        return res.status(400).json({message: 'Invalid username or password'});
    }

    res.status(200).json({message: 'User logged in successfully'});
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
