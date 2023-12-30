const express = require('express');
const app = express();

const categoriesData = [
    {
        name: 'Electronics',
        image: '🖥'
    },
    {
        name: 'Fashion',
        image: '👔'
    },
    {
        name: 'Office',
        image: '📁'
    },
    {
        name: 'Sports',
        image: '🏎'
    },
    {
        name: 'Books',
        image: '📚'
    }
];

const productsData = [
    {
        name: 'MacBook Pro 14',
        price: 1999,
        image: 'MacBook',
        info: 'MacBook Pro blasts forward...',
        available: true,
        category: 'Electronics'
    },
    {
        name: 'iPhone 15 Pro',
        price: 999,
        image: 'iPhone',
        info: 'iPhone 15 Pro is the first iPhone...',
        available: true,
        category: 'Electronics'
    },
    {
        name: 'AirPods Pro',
        price: 249,
        image: 'AirPods',
        info: 'Lorem ipsum',
        available: true,
        category: 'Electronics'
    },
    {
        name: 'Leather Jacket',
        price: 999,
        image: 'Jacket',
        info: 'Lorem ipsum',
        available: false,
        category: 'Fashion'
    },
    {
        name: 'Nike Air Jordan 1',
        price: 200,
        image: 'Jordan',
        info: 'Lorem ipsum',
        available: false,
        category: 'Fashion'
    },
    {
        name: 'Black Suit',
        price: 500,
        image: 'Suit',
        info: 'Lorem ipsum',
        available: true,
        category: 'Fashion'
    },
    {
        name: 'Pen',
        price: 200,
        image: 'Pen',
        info: 'Lorem ipsum',
        available: true,
        category: 'Office'
    },
    {
        name: 'Notebook',
        price: 99,
        image: 'Notebook',
        info: 'Lorem ipsum',
        available: true,
        category: 'Office'
    },
    {
        name: 'Pencils x10',
        price: 9,
        image: 'Pencils',
        info: 'Lorem ipsum',
        available: true,
        category: 'Office'
    },
    {
        name: 'Ferrari Fan T-Shirt',
        price: 99,
        image: 'Ferrari',
        info: 'Lorem ipsum',
        available: true,
        category: 'Sports'
    },
    {
        name: 'Mercedes Fan T-Shirt',
        price: 99,
        image: 'Mercedes',
        info: 'Lorem ipsum',
        available: true,
        category: 'Sports'
    },
    {
        name: 'Gokart',
        price: 99,
        image: 'Gokart',
        info: 'Lorem ipsum',
        available: true,
        category: 'Sports'
    },
    {
        name: 'Innovators',
        price: 99,
        image: 'Innovators',
        info: 'Lorem ipsum',
        available: true,
        category: 'Books'
    },
    {
        name: 'Steve Jobs',
        price: 99,
        image: 'Jobs',
        info: 'Lorem ipsum',
        available: true,
        category: 'Books'
    },
    {
        name: 'Machine Learning in Medicine',
        price: 85,
        image: 'ML',
        info: 'Lorem ipsum',
        available: true,
        category: 'Books'
    }
];

app.get('/categories', (req, res) => {
    res.json(categoriesData);
});

app.get('/products', (req, res) => {
    res.json(productsData);
});

app.listen(3000, () => {
    console.log('Server is listening on http://localhost:3000');
});
