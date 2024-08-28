
import express from 'express';
import bodyParser from 'body-parser';
import mongoose from 'mongoose';
import 'dotenv/config.js';
import cors from 'cors'
import asyncHandler from 'express-async-handler'
import Categories from './routes/category.js';
import SubCategories from './routes/subCategory.js';
import Brands from './routes/brand.js';
import Coupon from './routes/couponCode.js';
import Order from './routes/order.js';
import Notifications from './routes/notification.js';
import Payment from './routes/payment.js';
import Poster from './routes/poster.js';
import Product from './routes/product.js';
import User from './routes/user.js';
import Variants from './routes/variant.js';
import VariantTypes from './routes/variantType.js'

// Variables
const app = express();
const port = process.env.PORT || 3000
const connection_string = process.env.DB_CONNECTION_STRING;

//Middleware
app.use(bodyParser.json());
app.use(cors({origin: '*'}))

// Database connection
mongoose.connect(connection_string);
const db = mongoose.connection;
db.on('error', (error) => console.error(error));
db.once('open', () => console.log('Connected to Database'));

//? Setting static folder path
app.use('/image/product', express.static('public/products'));
app.use('/image/category', express.static('public/category'));
app.use('/image/poster', express.static('public/posters'));

// Routes
app.use('/categories', Categories);
app.use('/subCategories', SubCategories);
app.use('/brands', Brands);
app.use('/coupons', Coupon);
app.use('/orders', Order);
app.use('/notifications', Notifications);
app.use('/payment', Payment);
app.use('/posters', Poster);
app.use('/products', Product);
app.use('/user', User);
app.use('/variants', Variants);
app.use('/variantTypes', VariantTypes);


//TODO:  this

//test error handler
// app.use(asyncHandler(async(err, req, res, next)=> {
//   res.status(500).json({success: false, message: `Error: ${err.message}`, data: null}, )
// }))


app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
