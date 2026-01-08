// mongodb_operations.js

// ------------- Setup -------------
const { MongoClient } = require("mongodb");
const fs = require("fs");

const uri = "mongodb://localhost:27017"; // Replace with your MongoDB URI
const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    const db = client.db("fleximart");
    const products = db.collection("products");

    // ---------------- Operation 1: Load Data ----------------
    const data = JSON.parse(fs.readFileSync("products_catalog.json", "utf-8"));
    await products.insertMany(data);
    console.log("Products data inserted successfully.");

    // ---------------- Operation 2: Basic Query ----------------
    const electronicsUnder50k = await products
      .find({ category: "Electronics", price: { $lt: 50000 } }, { projection: { _id: 0, name: 1, price: 1, stock: 1 } })
      .toArray();
    console.log("\nElectronics under 50k:", electronicsUnder50k);

    // ---------------- Operation 3: Review Analysis ----------------
    const highRatedProducts = await products
      .aggregate([
        {
          $addFields: {
            avgRating: { $avg: "$reviews.rating" }
          }
        },
        {
          $match: { avgRating: { $gte: 4.0 } }
        },
        {
          $project: { _id: 0, name: 1, avgRating: 1 }
        }
      ])
      .toArray();
    console.log("\nProducts with average rating >= 4.0:", highRatedProducts);

    // ---------------- Operation 4: Update Operation ----------------
    await products.updateOne(
      { product_id: "ELEC001" },
      {
        $push: {
          reviews: {
            user_id: "U999",
            username: "Anonymous",
            rating: 4,
            comment: "Good value",
            date: new Date()
          }
        }
      }
    );
    console.log("\nNew review added to ELEC001.");

    // ---------------- Operation 5: Complex Aggregation ----------------
    const avgPriceByCategory = await products
      .aggregate([
        {
          $group: {
            _id: "$category",
            avg_price: { $avg: "$price" },
            product_count: { $sum: 1 }
          }
        },
        {
          $project: { _id: 0, category: "$_id", avg_price: 1, product_count: 1 }
        },
        { $sort: { avg_price: -1 } }
      ])
      .toArray();
    console.log("\nAverage price by category:", avgPriceByCategory);

  } catch (err) {
    console.error("Error:", err);
  } finally {
    await client.close();
  }
}

run();
