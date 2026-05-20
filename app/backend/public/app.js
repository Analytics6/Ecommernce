const productList = document.getElementById('product-list');
const cartItems = document.getElementById('cart-items');
const cartTotal = document.getElementById('cart-total');
const checkoutButton = document.getElementById('checkout-button');
let cart = [];

function formatCurrency(amount, currency = 'USD') {
  return new Intl.NumberFormat('en-US', { style: 'currency', currency }).format(amount);
}

function renderCart(currency) {
  cartItems.innerHTML = '';
  let total = 0;

  cart.forEach(item => {
    total += item.quantity * item.price;
    const row = document.createElement('div');
    row.className = 'cart-item';
    row.innerHTML = `
      <span>${item.name}</span>
      <span>${item.quantity} × ${formatCurrency(item.price, currency)}</span>
    `;
    cartItems.appendChild(row);
  });

  cartTotal.textContent = `Total: ${formatCurrency(total, currency)}`;
  checkoutButton.disabled = cart.length === 0;
}

function addToCart(product) {
  const existing = cart.find(item => item.id === product.id);
  if (existing) {
    existing.quantity += 1;
  } else {
    cart.push({ ...product, quantity: 1 });
  }
  renderCart(window.appCurrency);
}

async function checkout() {
  const response = await fetch('/api/checkout', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ cart, customer: { name: 'Guest' } })
  });
  const result = await response.json();

  if (response.ok) {
    alert(`Order submitted: ${result.orderId} - ${formatCurrency(result.total, result.currency)}`);
    cart = [];
    renderCart(window.appCurrency);
  } else {
    alert(`Checkout error: ${result.error}`);
  }
}

async function loadProducts() {
  try {
    const response = await fetch('/api/products');
    const data = await response.json();
    window.appCurrency = data.currency;
    productList.innerHTML = data.products.map(product => `
      <article class="card">
        <h3>${product.name}</h3>
        <p>${product.description}</p>
        <strong>${formatCurrency(product.price, data.currency)}</strong>
        <button onclick='addToCart(${JSON.stringify(product)})'>Add to cart</button>
      </article>
    `).join('');
    renderCart(data.currency);
  } catch (error) {
    productList.innerHTML = '<p class="error">Unable to load products. Try again later.</p>';
  }
}

checkoutButton.addEventListener('click', checkout);
loadProducts();
