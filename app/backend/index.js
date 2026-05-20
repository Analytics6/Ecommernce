const express = require('express');
const path = require('path');
const helmet = require('helmet');
const cors = require('cors');
const morgan = require('morgan');

const app = express();
const port = process.env.PORT || 8080;
const products = require('./data/products.json');

app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(morgan('combined'));
app.use(express.static(path.join(__dirname, 'public')));

app.get('/api/health', (req, res) => {
  res.status(200).json({ status: 'healthy', uptime: process.uptime() });
});

app.get('/api/products', (req, res) => {
  res.json({ products, currency: process.env.CURRENCY || 'USD' });
});

app.post('/api/checkout', (req, res) => {
  const { cart, customer } = req.body;
  if (!Array.isArray(cart) || cart.length === 0) {
    return res.status(400).json({ error: 'Cart is empty or invalid' });
  }

  const total = cart.reduce((sum, item) => sum + item.quantity * item.price, 0);
  return res.status(200).json({
    message: 'Checkout simulated successfully',
    total,
    currency: process.env.CURRENCY || 'USD',
    orderId: `ORD-${Date.now()}`
  });
});

app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(port, () => {
  console.log(`Ecommerce backend is running on port ${port}`);
});
