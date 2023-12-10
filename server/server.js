const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");

const app = express();
const PORT = 3000;

app.use(bodyParser.json());

mongoose.connect("mongodb://localhost:27017/flutter_express_mongodb_login", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

const User = mongoose.model("User", {
    username: String,
    password: String,
});

app.post("/api/login", async (req, res) => {
    const { username, password } = req.body;

    const user = await User.findOne({ username, password });

    if (user) {
        res.json({ success: true, message: "Login successful" });
    } else {
        res.json({ success: false, message: "Invalid credentials" });
    }
});

app.post("/api/signup", async (req, res) => {
    const { username, password } = req.body;

    const existingUser = await User.findOne({ username });

    if (existingUser) {
        res.json({ success: false, message: "Username already exists" });
    } else {
        const newUser = new User({ username, password });
        await newUser.save();
        res.json({ success: true, message: "Signup successful" });
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
