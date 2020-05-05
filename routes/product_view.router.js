const express = require('express');
const product_view_router = express.Router();
const product_view_controller = require('../controller/product.view.controller')
product_view_router.get('/:id',product_view_controller.view)
product_view_router.get('/',product_view_controller.view)
module.exports = product_view_router;