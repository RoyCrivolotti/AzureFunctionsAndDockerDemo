const axios = require('../node_modules/axios');
require('../node_modules/dotenv').config();

function getProduct(req, res) {
	axios.get(`http://${process.env.IP}/api/products/get/${req.query.ProductId}`)
		.then(response => res.render('/product', { product: response.data }))
		.catch(err => res.render('error', { message: 'Something went wrong :/', err }));
}

function getProducts(req, res) {
	console.log(`IP: ${process.env.IP}`);
	axios.get(`http://${process.env.IP}/api/products/getall`)
		.then(response => res.render('index', { title: 'This is a super basic app to consume an Azure Functions API demo :)',
			products: response.data }))
		.catch(err => res.render('error', { message: 'Something went wrong :/', err }));
}

function createProduct(req, res) {
	axios.post(`http://${process.env.IP}/api/products/create/`, { productName: req.body.ProductName })
		.then(response => res.render('index', { products: response.data }))
		.catch(err => res.render('error', { message: 'Something went wrong :/', err }));
}

function deleteProduct(req, res) {
	axios.delete(`http://${process.env.IP}/api/products/delete/${req.body.ProductId}`)
		.then(response => res.render('index', { products: response.data }))
		.catch(err => res.render('error', { message: 'Something went wrong :/', err }));
}

function updateProduct(req, res) {
	axios.put(`http://${process.env.IP}/api/products/update/${req.body.ProductId}`, { productName: req.body.ProductName })
		.then(response => res.render('index', { products: response.data }))
		.catch(err => res.render('error', { message: 'Something went wrong :/', err }));
}

module.exports = {
	getProduct,
	getProducts,
	createProduct,
	updateProduct,
	deleteProduct,
};
