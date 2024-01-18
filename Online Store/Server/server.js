const express = require('express');
const app = express();
const fs = require('fs');

const categoriesData = [{
    name: 'Electronics', image: '🖥'
}, {
    name: 'Fashion', image: '👔'
}, {
    name: 'Office', image: '📁'
}, {
    name: 'Sports', image: '🏎'
}, {
    name: 'Books', image: '📚'
}];

const productsData = [{
    name: 'MacBook Pro 14',
    price: 1999,
    image: 'MacBook',
    info: 'The MacBook Pro is a powerful and sleek laptop designed for professionals and creative individuals. With its high-performance processors and generous storage options, it handles demanding tasks with ease. The stunning Retina display delivers vibrant colors and sharp details, making it ideal for graphic design, editing videos, or watching movies. Its Touch Bar adds a dynamic element to your workflow, providing intuitive shortcuts and controls. The MacBook Pro\'s long battery life and lightweight design make it a portable option for working on the go. Whether you\'re a designer, developer, or content creator, the MacBook Pro offers the performance and versatility you need.',
    available: true,
    category: 'Electronics'
}, {
    name: 'iPhone 15 Pro',
    price: 999,
    image: 'iPhone',
    info: 'The iPhone 15 Pro is a cutting-edge smartphone that takes mobile technology to the next level. Its sleek design and edge-to-edge display offer an immersive visual experience. The powerful A-series chip ensures smooth performance and lightning-fast speeds. The advanced camera system captures stunning photos and videos with enhanced low-light capabilities and optical zoom. With its 5G connectivity, you can enjoy faster download speeds and seamless streaming. The iPhone 15 Pro also features an improved battery life, allowing you to stay connected throughout the day. Whether you\'re a photography enthusiast, a gamer, or a multitasker, the iPhone 15 Pro delivers unmatched performance and innovation.',
    available: true,
    category: 'Electronics'
}, {
    name: 'AirPods Pro',
    price: 249,
    image: 'AirPods',
    info: 'The AirPods Pro is a premium wireless earphone option that offers a truly immersive audio experience. With active noise cancellation, it blocks out external sounds, allowing you to focus on your music or calls. The adaptive EQ automatically tunes the music to the shape of your ear, delivering a rich and balanced audio output. The transparency mode lets you hear what\'s going on around you without removing the earphones. The AirPods Pro is water and sweat-resistant, making it suitable for workouts and outdoor activities. Its wireless charging case provides convenience and extended battery life. Upgrade your music listening with the AirPods Pro\'s exceptional sound quality and advanced features.',
    available: true,
    category: 'Electronics'
}, {
    name: 'Leather Jacket',
    price: 499,
    image: 'Jacket',
    info: 'The leather jacket is a timeless and versatile fashion staple that exudes style and sophistication. Crafted from high-quality leather, it offers durability and a sleek appearance. Its classic design makes it suitable for various occasions, whether it\'s a casual outing or a night out on the town. The jacket provides a layer of warmth and protection, making it ideal for colder seasons. With its tailored fit and flattering silhouette, it enhances any outfit and adds a touch of rugged elegance. Embrace the timeless appeal and enduring popularity of the leather jacket for a chic and edgy look.',
    available: false,
    category: 'Fashion'
}, {
    name: 'Nike Air Jordan 1',
    price: 200,
    image: 'Jordan',
    info: 'The Nike Air Jordan 1 is an iconic and legendary sneaker that revolutionized the world of athletic footwear. Designed in collaboration with basketball legend Michael Jordan, it boasts a stylish and high-top silhouette with iconic Jordan branding. The Air Jordan 1 combines premium materials and superior craftsmanship for both comfort and durability. Its Air cushioning technology provides excellent impact protection, making it a favorite among athletes and sneaker enthusiasts. Available in a wide range of colorways and limited editions, the Air Jordan 1 offers endless style options for both on and off the court. Step into history and elevate your sneaker game with the timeless Air Jordan 1.',
    available: false,
    category: 'Fashion'
}, {
    name: 'Black Suit',
    price: 999,
    image: 'Suit',
    info: 'The black suit is a classic and timeless wardrobe staple for any formal occasion. With its sleek and sophisticated design, it exudes elegance and professionalism. The tailored fit enhances your silhouette, providing a sharp and polished look. Made from high-quality fabrics, the black suit offers comfort and durability. It serves as a versatile ensemble, allowing you to pair it with a crisp white shirt and a variety of accessories for different occasions. Whether it\'s a business meeting, a wedding, or a formal event, the black suit is a go-to choice that never goes out of style.',
    available: true,
    category: 'Fashion'
}, {
    name: 'Pen',
    price: 25,
    image: 'Pen',
    info: 'The pen is a practical and essential writing tool that provides a smooth and precise writing experience. With various styles and designs available, you can choose a pen that suits your personal preference. From ballpoint pens to rollerball pens or fountain pens, each type offers different ink flow and thickness options. Whether you use it for note-taking, writing, or sketching, the pen allows you to create clear and legible lines. Compact and portable, it easily fits into pockets, bags, or pen holders. Invest in a reliable pen to enhance your writing experience and make everyday tasks more enjoyable.',
    available: true,
    category: 'Office'
}, {
    name: 'Notebook',
    price: 19,
    image: 'Notebook',
    info: 'The notebook is a versatile and indispensable tool for organizing your thoughts, jotting down ideas, or keeping track of important information. Available in different sizes and styles, you can choose a notebook that suits your needs. The pages are typically lined, blank, or grid-patterned, providing flexibility for writing, doodling, or even sketching. Whether you prefer a spiral-bound notebook for easy flipping or a hardcover journal for a more durable option, notebooks offer a portable and convenient way to capture and organize your thoughts. They are perfect for work, school, or personal use, allowing you to stay organized and express your creativity wherever you go.',
    available: true,
    category: 'Office'
}, {
    name: 'Pencils x10',
    price: 10,
    image: 'Pencil',
    info: 'Pencils are essential writing tools that come in a set of 10, providing you with a reliable and versatile option for various writing and drawing needs. With their graphite cores, these pencils offer smooth and consistent lines. The wooden barrels provide a comfortable grip, ensuring a pleasant writing experience. The set of 10 pencils allows you to have an ample supply for personal or professional use. Whether you\'re sketching, drafting, or simply jotting down notes, these pencils offer durability and versatility in a convenient package. Keep a set of pencils on hand for all your writing and artistic endeavors.',
    available: true,
    category: 'Office'
}, {
    name: 'Scuderia Ferrari Polo Shirt',
    price: 81,
    image: 'Ferrari',
    info: 'The Scuderia Ferrari Polo Shirt is a stylish and sophisticated polo shirt that embodies the spirit of the legendary Italian racing team. Made from premium materials, it offers comfort, durability, and a sleek fit. The polo shirt features the iconic Scuderia Ferrari logo, showcasing your passion for motorsport and high-performance cars. With its classic polo collar and sleek design, it exudes elegance and sporty sophistication. Whether you\'re attending a race or simply want to embrace the racing heritage, the Scuderia Ferrari Polo Shirt is an essential addition to your wardrobe. Show your support for the team with this iconic and fashion-forward polo shirt.',
    available: true,
    category: 'Sports'
}, {
    name: 'Mercedes Petronas Polo Shirt',
    price: 76,
    image: 'Mercedes',
    info: 'The Mercedes Petronas Polo Shirt is a stylish and high-quality polo shirt that represents the Mercedes-AMG Petronas Formula One Team. Made from premium fabrics, it offers comfort, breathability, and a modern fit. The polo shirt features the iconic Mercedes logo and team branding, showcasing your support for the championship-winning team. With its classic polo collar and sleek design, it combines sporty elegance with a touch of sophistication. Whether you\'re cheering trackside or simply want to showcase your passion for motorsport, the Mercedes Petronas Polo Shirt is a must-have for any fan. Embrace the style and performance of the Mercedes-AMG Petronas team with this fashionable and iconic polo shirt.',
    available: true,
    category: 'Sports'
}, {
    name: 'Go-kart',
    price: 2499,
    image: 'Gokart',
    info: 'A go-kart is a small, open-wheel vehicle designed for recreational and competitive racing. It offers a thrilling and exhilarating experience for drivers of all ages. Go-karts are typically powered by small engines, either gas or electric, and can reach impressive speeds on the track. They feature a compact design with a low center of gravity, allowing for sharp turns and agile handling. Go-karting is a popular activity for racing enthusiasts, providing an opportunity to test driving skills and enjoy friendly competition. Whether you\'re a novice or an experienced driver, go-karting promises an adrenaline-pumping adventure that\'s bound to bring out your inner race car driver.',
    available: true,
    category: 'Sports'
}, {
    name: '\"Innovators\" by Walter Isaacson',
    price: 34,
    image: 'Innovators',
    info: '\"Innovators\" is a book written by Walter Isaacson that explores the history and impact of digital innovation. It delves into the lives and contributions of some of the world\'s greatest innovators, including Ada Lovelace, Alan Turing, Bill Gates, Steve Jobs, and many others. Isaacson takes readers on a captivating journey through the development of computers, the internet, and the digital revolution. Through detailed storytelling, he highlights the qualities that make these innovators unique and examines the collaborative nature of progress. \"Innovators\" is a thought-provoking book that sheds light on the individuals and ideas that have shaped our modern technological landscape.',
    available: true,
    category: 'Books'
}, {
    name: '\"Steve Jobs\" by Walter Isaacson',
    price: 19,
    image: 'Jobs',
    info: '\"Steve Jobs\" is a biography written by Walter Isaacson that offers a comprehensive look into the life and achievements of the iconic co-founder of Apple Inc., Steve Jobs. Based on extensive research and interviews conducted with Jobs, his family, and colleagues, Isaacson provides an intimate portrait of the visionary entrepreneur. The book explores Jobs\' personal and professional journey, from his early days founding Apple in a garage to his significant impact on the technology, entertainment, and design industries. Isaacson delves into Jobs\' personality, leadership style, and creative genius, highlighting both his strengths and flaws. \"Steve Jobs\" is an insightful and revealing biography that provides a deep understanding of one of the most influential and enigmatic figures in modern history.',
    available: true,
    category: 'Books'
}, {
    name: '\"Explainable Machine Learning in Medicine\" by Karol Przystalski & Rohit M. Thanki',
    price: 85,
    image: 'ML',
    info: 'Provides a primer on explainable artificial intelligence and machine learning methods that can be used in medical cases. Presents how explainable AI aids in choosing ML algorithms that give better performance in medical applications. Covers medical data used to diagnose diseases in clinic centers and what technologies are best suited to analyze it',
    available: true,
    category: 'Books'
}];

app.get('/categories', (req, res) => {
    res.json(categoriesData);
});

app.get('/products', (req, res) => {
    res.json(productsData);
});

app.get('/images/:image', (req, res) => {
    const imageName = req.params.image;
    const imagePath = __dirname + '/images/' + imageName;

    if (fs.existsSync(imagePath)) {
        const imageStream = fs.createReadStream(imagePath);
        res.setHeader('Content-Type', 'image/png'); // Adjust the content type according to your image format
        imageStream.pipe(res);
    } else {
        res.sendStatus(404);
    }
});


app.listen(3000, () => {
    console.log('Server is listening on http://localhost:3000');
});
