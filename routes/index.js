const express = require('../node_modules/express');
const controller = require('../controllers/mainController');

const router = express.Router();

router.get('/', controller.getProducts);
router.get('/getProduct', controller.getProduct);
router.post('/createProduct', controller.createProduct);
router.post('/updateProduct', controller.updateProduct);
router.post('/deleteProduct', controller.deleteProduct);

module.exports = router;
