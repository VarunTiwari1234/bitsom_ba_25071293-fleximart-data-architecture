/**
 * FlexiMart MongoDB Operations
 * Project: Task 2.2 Practical Implementation
 */

// --- Operation 1: Load Data ---
// Instruction: Import the provided JSON file into collection 'products'
// Command for MongoDB Shell (run from terminal):
// mongoimport --db fleximart --collection products --file products_catalog.json --jsonArray


// --- Operation 2: Basic Query ---
// Business Question: Find all products in "Electronics" category with price less than 50000
// Return only: name, price, stock
db.products.find(
    { 
        category: "Electronics", 
        price: { $lt: 50000 } 
    },
    { 
        name: 1, 
        price: 1, 
        stock: 1, 
        _id: 0 
    }
);


// --- Operation 3: Review Analysis ---
// Business Question: Find all products that have average rating >= 4.0
// Use aggregation to calculate average from reviews array
db.products.aggregate([
    {
        $project: {
            name: 1,
            avgRating: { $avg: "$reviews.rating" }
        }
    },
    {
        $match: {
            avgRating: { $gte: 4.0 }
        }
    }
]);


// --- Operation 4: Update Operation ---
// Business Question: Add a new review to product "ELEC001"
// Review: {user_id: "U999", rating: 4, comment: "Good value", date: ISODate()}
db.products.updateOne(
    { product_id: "ELEC001" },
    { 
        $push: { 
            reviews: { 
                user_id: "U999", 
                username: "NewReviewer",
                rating: 4, 
                comment: "Good value", 
                date: new Date() // Using native Date for ISODate compatibility
            } 
        } 
    }
);


// --- Operation 5: Complex Aggregation ---
// Business Question: Calculate average price by category
// Return: category, avg_price, product_count
// Sort by avg_price descending
db.products.aggregate([
    {
        $group: {
            _id: "$category",
            avg_price: { $avg: "$price" },
            product_count: { $sum: 1 }
        }
    },
    {
        $sort: { avg_price: -1 }
    },
    {
        $project: {
            category: "$_id",
            avg_price: 1,
            product_count: 1,
            _id: 0
        }
    }
]);