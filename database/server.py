from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from typing import List, Optional
import sqlite3
import json
from contextlib import contextmanager
import uvicorn

app = FastAPI(title="Food Delivery API", version="1.0.0")

# Database setup
DATABASE_URL = "food_delivery.db"
def init_db():
    """Initialize the database with tables and sample data"""
    import os
    import sqlite3
    import json
    
    if os.path.exists(DATABASE_URL):
        return
    
    conn = sqlite3.connect(DATABASE_URL)
    cursor = conn.cursor()
    
    # Users table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            phone_number TEXT NOT NULL,
            address TEXT NOT NULL,
            profile_picture_url TEXT
        )
    ''')
    
    # Vendors table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS vendors (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            subtitle TEXT,
            image_url TEXT,
            background_color TEXT,
            rating REAL,
            delivery_time TEXT,
            is_favorite BOOLEAN DEFAULT FALSE,
            categories_id TEXT
        )
    ''')
    
    # Food table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS food (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT,
            image_url TEXT,
            price REAL NOT NULL,
            vendor_id TEXT NOT NULL,
            is_available BOOLEAN DEFAULT TRUE,
            FOREIGN KEY (vendor_id) REFERENCES vendors (id)
        )
    ''')
    
    # Orders table
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS orders (
            id TEXT PRIMARY KEY,
            vendor_id TEXT NOT NULL,
            user_id TEXT NOT NULL,
            order_date TEXT NOT NULL,
            delivery_time TEXT,
            total_price REAL NOT NULL,
            food_ids TEXT,
            FOREIGN KEY (vendor_id) REFERENCES vendors (id),
            FOREIGN KEY (user_id) REFERENCES users (id)
        )
    ''')
    
    # Define colors as hex strings (converted from Flutter Color values)
    colors = [
        "#FF9800",  # Color(0xFFFF9800)
        "#FFC107",  # Color(0xFFFFC107)
        "#795548",  # Color(0xFF795548)
        "#2E7D32",  # Color(0xFF2E7D32)
        "#E91E63",  # Color(0xFFE91E63)
        "#9C27B0",  # Color(0xFF9C27B0)
        "#3F51B5",  # Color(0xFF3F51B5)
        "#00BCD4",  # Color(0xFF00BCD4)
    ]
    
    # Vendor data
    vendors_data = [
        {
            'name': 'Manja Burger',
            'type': 'American • Burgers',
            'rating': 4.5,
            'time': '25-30 min',
            'categories_id': {'1'},
            'image_URL': 'https://scontent.fpen1-1.fna.fbcdn.net/v/t39.30808-6/303285053_516179960511643_2624171546720026263_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=QjIdxrzea-4Q7kNvwGRsCIR&_nc_oc=Adnrnk5Dvw8C7NPF1reRFU_Vb40g0cBTKYCeFaO6p2UygD7oYGQPkgNB9o_utEcD4Ck&_nc_zt=23&_nc_ht=scontent.fpen1-1.fna&_nc_gid=szykECY-FA6QcVBH_7MqHg&oh=00_AfMlIIdeUJ-wM2wb2N5M74sILYfHI4n4iB1rbv0yftE7XQ&oe=6851B86D',
        },
        {
            'name': 'He and She Coffee',
            'type': 'Coffee • Desserts',
            'rating': 4.2,
            'time': '15-20 min',
            'categories_id': {'5', '7', '4'},
            'image_URL': 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/43/20/23/they-also-outdoor-seat.jpg?w=1400&h=800&s=1',
        },
        {
            'name': 'Cafe V2 GEE & S',
            'type': 'Malay • Rice',
            'rating': 4.7,
            'time': '30-35 min',
            'categories_id': {'2'},
            'image_URL': 'https://www.utp.edu.my/PublishingImages/Pages/Students/Student%20Development%20and%20Services/Facilities%20and%20Services/Cafeteria/2023/Village%202%20-%20Gee%20%26%20S.jpg',
        },
        {
            'name': 'Pasta V4',
            'type': 'Italian • Pasta',
            'rating': 4.4,
            'time': '20-25 min',
            'categories_id': {'1', '2'},
            'image_URL': 'https://www.utp.edu.my/PublishingImages/Pages/Students/Student%20Development%20and%20Services/Facilities%20and%20Services/Cafeteria/2023/Village%204%20-%20Zaitom%20Razak%20Cafe.jpg',
        },
        {
            'name': 'V5 Afifah Beta',
            'type': 'Healthy • Smoothies',
            'rating': 4.6,
            'time': '10-15 min',
            'categories_id': {'5', '7'},
            'image_URL': 'https://www.utp.edu.my/PublishingImages/Pages/Students/Student%20Development%20and%20Services/Facilities%20and%20Services/Cafeteria/2023/Village%205%20(b)%20-%20Afifah%20Beta.jpg',
        },
    ]
    
    # Insert vendor data
    for index, vendor in enumerate(vendors_data):
        vendor_id = str(index + 1)
        categories_json = json.dumps(list(vendor['categories_id']))  # Convert set to JSON string
        
        cursor.execute('''
            INSERT INTO vendors (
                id, name, subtitle, image_url, background_color, 
                rating, delivery_time, is_favorite, categories_id
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            vendor_id,
            vendor['name'],
            vendor['type'],
            vendor['image_URL'],
            colors[index],
            vendor['rating'],
            vendor['time'],
            False,  # is_favorite default
            categories_json
        ))
        
    # Food items data
    food_items_data = [
        # Manja Burger (vendor_id: "1")
        {
            'name': 'Classic Beef Burger',
            'description': 'Juicy beef patty with lettuce, tomato, onion, and special sauce',
            'image_url': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
            'price': 12.90,
            'vendor_id': '1'
        },
        {
            'name': 'Chicken Deluxe',
            'description': 'Crispy chicken breast with cheese, bacon, and mayo',
            'image_url': 'https://images.unsplash.com/photo-1606755962773-d324e9a13086?w=400',
            'price': 14.50,
            'vendor_id': '1'
        },
        {
            'name': 'Manja Special',
            'description': 'Double beef patty with special Manja sauce and grilled onions',
            'image_url': 'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=400',
            'price': 18.90,
            'vendor_id': '1'
        },
        
        # He and She Coffee (vendor_id: "2")
        {
            'name': 'Americano',
            'description': 'Rich and bold espresso with hot water',
            'image_url': 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=400',
            'price': 8.50,
            'vendor_id': '2'
        },
        {
            'name': 'Cappuccino',
            'description': 'Espresso with steamed milk and foam art',
            'image_url': 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400',
            'price': 9.90,
            'vendor_id': '2'
        },
        {
            'name': 'Chocolate Cake',
            'description': 'Rich chocolate cake with vanilla cream',
            'image_url': 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400',
            'price': 12.00,
            'vendor_id': '2'
        },
        {
            'name': 'Iced Latte',
            'description': 'Cold espresso with milk and ice',
            'image_url': 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400',
            'price': 10.50,
            'vendor_id': '2'
        },
        
        # Cafe V2 GEE & S (vendor_id: "3")
        {
            'name': 'Nasi Lemak',
            'description': 'Coconut rice with sambal, anchovies, peanuts, and egg',
            'image_url': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
            'price': 7.50,
            'vendor_id': '3'
        },
        {
            'name': 'Mee Goreng',
            'description': 'Spicy fried noodles with vegetables and egg',
            'image_url': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400',
            'price': 8.90,
            'vendor_id': '3'
        },
        {
            'name': 'Ayam Penyet',
            'description': 'Smashed fried chicken with sambal and vegetables',
            'image_url': 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=400',
            'price': 11.50,
            'vendor_id': '3'
        },
        {
            'name': 'Rendang Beef',
            'description': 'Slow-cooked beef in rich coconut curry',
            'image_url': 'https://images.unsplash.com/photo-1565299585323-38174c4a6471?w=400',
            'price': 13.90,
            'vendor_id': '3'
        },
        
        # Pasta V4 (vendor_id: "4")
        {
            'name': 'Spaghetti Carbonara',
            'description': 'Creamy pasta with bacon, egg, and parmesan cheese',
            'image_url': 'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5?w=400',
            'price': 15.90,
            'vendor_id': '4'
        },
        {
            'name': 'Penne Arrabbiata',
            'description': 'Spicy tomato sauce with garlic and chili',
            'image_url': 'https://images.unsplash.com/photo-1563379091339-03246963d293?w=400',
            'price': 14.50,
            'vendor_id': '4'
        },
        {
            'name': 'Fettuccine Alfredo',
            'description': 'Rich cream sauce with parmesan and herbs',
            'image_url': 'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?w=400',
            'price': 16.90,
            'vendor_id': '4'
        },
        {
            'name': 'Lasagna',
            'description': 'Layered pasta with meat sauce and cheese',
            'image_url': 'https://images.unsplash.com/photo-1574894709920-11b28e7367e3?w=400',
            'price': 18.50,
            'vendor_id': '4'
        },
        
        # V5 Afifah Beta (vendor_id: "5")
        {
            'name': 'Green Smoothie',
            'description': 'Spinach, banana, apple, and coconut water blend',
            'image_url': 'https://images.unsplash.com/photo-1610970881699-44a5587cabec?w=400',
            'price': 9.90,
            'vendor_id': '5'
        },
        {
            'name': 'Berry Blast',
            'description': 'Mixed berries with yogurt and honey',
            'image_url': 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=400',
            'price': 11.50,
            'vendor_id': '5'
        },
        {
            'name': 'Protein Bowl',
            'description': 'Quinoa, grilled chicken, avocado, and mixed greens',
            'image_url': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
            'price': 16.90,
            'vendor_id': '5'
        },
        {
            'name': 'Acai Bowl',
            'description': 'Acai puree topped with granola, fruits, and nuts',
            'image_url': 'https://images.unsplash.com/photo-1590301157890-4810ed352733?w=400',
            'price': 13.90,
            'vendor_id': '5'
        },
        {
            'name': 'Mango Lassi',
            'description': 'Creamy mango smoothie with yogurt and cardamom',
            'image_url': 'https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=400',
            'price': 8.50,
            'vendor_id': '5'
        }
    ]
    
    # Insert food items data
    for index, food in enumerate(food_items_data):
        food_id = str(index + 1)
        
        cursor.execute('''
            INSERT INTO food (
                id, name, description, image_url, price, vendor_id, is_available
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
        ''', (
            food_id,
            food['name'],
            food['description'],
            food['image_url'],
            food['price'],
            food['vendor_id'],
            True  # is_available default
        ))
    conn.commit()
    conn.close()
    print("Database initialized successfully with vendor data!")


@contextmanager
def get_db():
    """Database connection context manager"""
    conn = sqlite3.connect(DATABASE_URL)
    conn.row_factory = sqlite3.Row
    try:
        yield conn
    finally:
        conn.close()

# Pydantic models
class UserCreate(BaseModel):
    id: str
    name: str
    email: str
    phone_number: str
    address: str
    profile_picture_url: Optional[str] = ""

class UserResponse(BaseModel):
    id: str
    name: str
    email: str
    phone_number: str
    address: str
    profile_picture_url: str

class VendorCreate(BaseModel):
    id: str
    name: str
    subtitle: Optional[str] = ""
    image_url: Optional[str] = ""
    background_color: Optional[str] = "#FFFFFF"
    rating: Optional[float] = 0.0
    delivery_time: Optional[str] = "30 min"
    is_favorite: Optional[bool] = False
    categories_id: List[str] = []

class VendorResponse(BaseModel):
    id: str
    name: str
    subtitle: str
    image_url: str
    background_color: str
    rating: float
    delivery_time: str
    is_favorite: bool
    categories_id: List[str]

class FoodCreate(BaseModel):
    id: str
    name: str
    description: Optional[str] = ""
    image_url: Optional[str] = ""
    price: float
    vendor_id: str
    is_available: Optional[bool] = True

class FoodResponse(BaseModel):
    id: str
    name: str
    description: str
    image_url: str
    price: float
    vendor_id: str
    is_available: bool

class OrderCreate(BaseModel):
    id: str
    vendor_id: str
    user_id: str
    order_date: str
    delivery_time: Optional[str] = ""
    total_price: float
    food_ids: List[str] = []

class OrderResponse(BaseModel):
    id: str
    vendor_id: str
    user_id: str
    order_date: str
    delivery_time: str
    total_price: float
    food_ids: List[str]

# Initialize database on startup id not exist

init_db()

# USER ENDPOINTS
@app.post("/users/", response_model=UserResponse)
def create_user(user: UserCreate):
    with get_db() as conn:
        cursor = conn.cursor()
        try:
            cursor.execute('''
                INSERT INTO users (id, name, email, phone_number, address, profile_picture_url)
                VALUES (?, ?, ?, ?, ?, ?)
            ''', (user.id, user.name, user.email, user.phone_number, user.address, user.profile_picture_url))
            conn.commit()
            return user
        except sqlite3.IntegrityError:
            raise HTTPException(status_code=400, detail="User with this ID or email already exists")

@app.get("/users/", response_model=List[UserResponse])
def get_users():
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM users")
        users = cursor.fetchall()
        return [dict(user) for user in users]

@app.get("/users/{user_id}", response_model=UserResponse)
def get_user(user_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM users WHERE id = ?", (user_id,))
        user = cursor.fetchone()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        return dict(user)

@app.put("/users/{user_id}", response_model=UserResponse)
def update_user(user_id: str, user: UserCreate):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            UPDATE users SET name = ?, email = ?, phone_number = ?, address = ?, profile_picture_url = ?
            WHERE id = ?
        ''', (user.name, user.email, user.phone_number, user.address, user.profile_picture_url, user_id))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="User not found")
        conn.commit()
        return user

@app.delete("/users/{user_id}")
def delete_user(user_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM users WHERE id = ?", (user_id,))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="User not found")
        conn.commit()
        return {"message": "User deleted successfully"}

# VENDOR ENDPOINTS
@app.post("/vendors/", response_model=VendorResponse)
def create_vendor(vendor: VendorCreate):
    with get_db() as conn:
        cursor = conn.cursor()
        categories_json = json.dumps(vendor.categories_id)
        try:
            cursor.execute('''
                INSERT INTO vendors (id, name, subtitle, image_url, background_color, rating, delivery_time, is_favorite, categories_id)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''', (vendor.id, vendor.name, vendor.subtitle, vendor.image_url, vendor.background_color, 
                  vendor.rating, vendor.delivery_time, vendor.is_favorite, categories_json))
            conn.commit()
            return vendor
        except sqlite3.IntegrityError:
            raise HTTPException(status_code=400, detail="Vendor with this ID already exists")

@app.get("/vendors/", response_model=List[VendorResponse])
def get_vendors():
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM vendors")
        vendors = cursor.fetchall()
        result = []
        for vendor in vendors:
            vendor_dict = dict(vendor)
            vendor_dict['categories_id'] = json.loads(vendor_dict['categories_id'] or '[]')
            result.append(vendor_dict)
        return result

@app.get("/vendors/{vendor_id}", response_model=VendorResponse)
def get_vendor(vendor_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM vendors WHERE id = ?", (vendor_id,))
        vendor = cursor.fetchone()
        if not vendor:
            raise HTTPException(status_code=404, detail="Vendor not found")
        vendor_dict = dict(vendor)
        vendor_dict['categories_id'] = json.loads(vendor_dict['categories_id'] or '[]')
        return vendor_dict

@app.put("/vendors/{vendor_id}", response_model=VendorResponse)
def update_vendor(vendor_id: str, vendor: VendorCreate):
    with get_db() as conn:
        cursor = conn.cursor()
        categories_json = json.dumps(vendor.categories_id)
        cursor.execute('''
            UPDATE vendors SET name = ?, subtitle = ?, image_url = ?, background_color = ?, 
            rating = ?, delivery_time = ?, is_favorite = ?, categories_id = ?
            WHERE id = ?
        ''', (vendor.name, vendor.subtitle, vendor.image_url, vendor.background_color,
              vendor.rating, vendor.delivery_time, vendor.is_favorite, categories_json, vendor_id))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Vendor not found")
        conn.commit()
        return vendor

@app.delete("/vendors/{vendor_id}")
def delete_vendor(vendor_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM vendors WHERE id = ?", (vendor_id,))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Vendor not found")
        conn.commit()
        return {"message": "Vendor deleted successfully"}

# FOOD ENDPOINTS
@app.post("/food/", response_model=FoodResponse)
def create_food(food: FoodCreate):
    with get_db() as conn:
        cursor = conn.cursor()
        try:
            cursor.execute('''
                INSERT INTO food (id, name, description, image_url, price, vendor_id, is_available)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            ''', (food.id, food.name, food.description, food.image_url, food.price, food.vendor_id, food.is_available))
            conn.commit()
            return food
        except sqlite3.IntegrityError:
            raise HTTPException(status_code=400, detail="Food with this ID already exists")

@app.get("/food/", response_model=List[FoodResponse])
def get_food():
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM food")
        food_items = cursor.fetchall()
        return [dict(food) for food in food_items]

@app.get("/food/{food_id}", response_model=FoodResponse)
def get_food_item(food_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM food WHERE id = ?", (food_id,))
        food = cursor.fetchone()
        if not food:
            raise HTTPException(status_code=404, detail="Food item not found")
        return dict(food)

@app.get("/food/vendor/{vendor_id}", response_model=List[FoodResponse])
def get_food_by_vendor(vendor_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM food WHERE vendor_id = ?", (vendor_id,))
        food_items = cursor.fetchall()
        return [dict(food) for food in food_items]

@app.put("/food/{food_id}", response_model=FoodResponse)
def update_food(food_id: str, food: FoodCreate):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute('''
            UPDATE food SET name = ?, description = ?, image_url = ?, price = ?, vendor_id = ?, is_available = ?
            WHERE id = ?
        ''', (food.name, food.description, food.image_url, food.price, food.vendor_id, food.is_available, food_id))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Food item not found")
        conn.commit()
        return food

@app.delete("/food/{food_id}")
def delete_food(food_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM food WHERE id = ?", (food_id,))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Food item not found")
        conn.commit()
        return {"message": "Food item deleted successfully"}

# ORDER ENDPOINTS
@app.post("/orders/", response_model=OrderResponse)
def create_order(order: OrderCreate):
    with get_db() as conn:
        cursor = conn.cursor()
        food_ids_json = json.dumps(order.food_ids)
        try:
            cursor.execute('''
                INSERT INTO orders (id, vendor_id, user_id, order_date, delivery_time, total_price, food_ids)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            ''', (order.id, order.vendor_id, order.user_id, order.order_date, order.delivery_time, order.total_price, food_ids_json))
            conn.commit()
            return order
        except sqlite3.IntegrityError:
            raise HTTPException(status_code=400, detail="Order with this ID already exists")

@app.get("/orders/", response_model=List[OrderResponse])
def get_orders():
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM orders")
        orders = cursor.fetchall()
        result = []
        for order in orders:
            order_dict = dict(order)
            order_dict['food_ids'] = json.loads(order_dict['food_ids'] or '[]')
            result.append(order_dict)
        return result

@app.get("/orders/{order_id}", response_model=OrderResponse)
def get_order(order_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM orders WHERE id = ?", (order_id,))
        order = cursor.fetchone()
        if not order:
            raise HTTPException(status_code=404, detail="Order not found")
        order_dict = dict(order)
        order_dict['food_ids'] = json.loads(order_dict['food_ids'] or '[]')
        return order_dict

@app.get("/orders/user/{user_id}", response_model=List[OrderResponse])
def get_orders_by_user(user_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM orders WHERE user_id = ?", (user_id,))
        orders = cursor.fetchall()
        result = []
        for order in orders:
            order_dict = dict(order)
            order_dict['food_ids'] = json.loads(order_dict['food_ids'] or '[]')
            result.append(order_dict)
        return result

@app.get("/orders/vendor/{vendor_id}", response_model=List[OrderResponse])
def get_orders_by_vendor(vendor_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM orders WHERE vendor_id = ?", (vendor_id,))
        orders = cursor.fetchall()
        result = []
        for order in orders:
            order_dict = dict(order)
            order_dict['food_ids'] = json.loads(order_dict['food_ids'] or '[]')
            result.append(order_dict)
        return result

@app.put("/orders/{order_id}", response_model=OrderResponse)
def update_order(order_id: str, order: OrderCreate):
    with get_db() as conn:
        cursor = conn.cursor()
        food_ids_json = json.dumps(order.food_ids)
        cursor.execute('''
            UPDATE orders SET vendor_id = ?, user_id = ?, order_date = ?, delivery_time = ?, total_price = ?, food_ids = ?
            WHERE id = ?
        ''', (order.vendor_id, order.user_id, order.order_date, order.delivery_time, order.total_price, food_ids_json, order_id))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Order not found")
        conn.commit()
        return order

@app.delete("/orders/{order_id}")
def delete_order(order_id: str):
    with get_db() as conn:
        cursor = conn.cursor()
        cursor.execute("DELETE FROM orders WHERE id = ?", (order_id,))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Order not found")
        conn.commit()
        return {"message": "Order deleted successfully"}

# Health check endpoint
@app.get("/")
def root():
    return {"message": "Food Delivery API is running!"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)