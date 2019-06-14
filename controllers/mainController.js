const axios = require('../node_modules/axios');

function getProduct(req, res) {
	axios.get(`http://localhost:7071/api/products/get/${req.query.ProductId}`)
		.then(response => res.render('/product', { product: response.data }))
		.catch(err => res.render('error', { message: 'Something went wrong :/', err }));
}
function getProducts(req, res) {
	axios.get('http://localhost:7071/api/products/getall')
		.then(response => res.render('index', { title: 'This is a super basic app to consume an Azure Functions API demo :)',
			products: response.data }))
		.catch(err => res.render('error', { message: 'Something went wrong :/', err }));
}

function createProduct(req, res) {
	axios.post('http://localhost:7071/api/products/create/', { productName: req.body.ProductName })
		.then(response => res.render('index', { products: response.data }))
		.catch(err => res.render('error', { message: 'Something went wrong :/', err }));
}

function deleteProduct(req, res) {
	axios.delete(`http://localhost:7071/api/products/delete/${req.body.ProductId}`)
		.then(response => res.render('index', { products: response.data }))
		.catch(err => res.render('error', { message: 'Something went wrong :/', err }));
}

function updateProduct(req, res) {
	axios.put(`http://localhost:7071/api/products/update/${req.body.ProductId}`, { productName: req.body.ProductName })
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
