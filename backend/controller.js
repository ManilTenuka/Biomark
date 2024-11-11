const mysql = require('mysql2');
const bcrypt = require('bcryptjs');  // Import bcrypt

// Configure database connection directly
const db = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'biomark'
}).promise();

const register = async (req, res) => {
    const {
        username,
        email,
        password,
        date_of_birth,
        time_of_birth,
        location_of_birth,
        blood_group,
        sex,
        height,
        ethnicity,
        eye_colour
    } = req.body;

    try {
        // Check if the user already exists
        const [user] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
        if (user.length > 0) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Hash the password before saving it to the database
        const hashedPassword = await bcrypt.hash(password, 10);

        // Insert new user data into the database
        await db.query(
            `INSERT INTO users (username, email, password, date_of_birth, time_of_birth, location_of_birth, blood_group, sex, height, ethnicity, eye_colour) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [
                username,
                email,
                hashedPassword,
                date_of_birth,
                time_of_birth,
                location_of_birth,
                blood_group,
                sex,
                height,
                ethnicity,
                eye_colour
            ]
        );

        res.status(201).json({ message: 'User registered successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
};

const login = async (req, res) => {
    const { email, password } = req.body;

    try {
        const [user] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
        
        if (user.length === 0) {
            return res.status(400).json({ message: 'User not found' });
        }

        // Compare the provided password with the stored hashed password
        const isMatch = await bcrypt.compare(password, user[0].password);
        
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        // Return userId and email with the success response
        res.status(200).json({
            message: 'Login successful',
            id: user[0].id, // Assuming 'id' is the correct column name for user ID
            email: user[0].email, // Assuming 'email' is the correct column name for email
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
};

const update = async (req, res) => {
    const { id, email, password, height, ethnicity, eyeColor } = req.body;

    // Validate the request body
    if (!id || !email || !password || !height || !ethnicity || !eyeColor) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    try {
        // Hash the new password before saving it to the database
        const hashedPassword = await bcrypt.hash(password, 10);

        // Update user info in the database
        const [result] = await db.query(
            `UPDATE users SET email = ?, password = ?, height = ?, ethnicity = ?, eye_colour = ? WHERE id = ?`,
            [email, hashedPassword, height, ethnicity, eyeColor, id]
        );

        // Check if any rows were affected (i.e., if the update was successful)
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Respond with a success message
        res.status(200).json({ message: 'User info updated successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
};

const getUserDetails = async (req, res) => {
    const { id } = req.params; 
  
    try {
      // Query the database to find the user by id
      const [user] = await db.query('SELECT * FROM users WHERE id = ?', [id]);
  
      // Check if user was found
      if (user.length === 0) {
        return res.status(404).json({ message: 'User not found' });
      }
  
      // Respond with user details
      res.status(200).json({
        id: user[0].id,
        email: user[0].email,
        height: user[0].height,
        ethnicity: user[0].ethnicity,
        eye_color: user[0].eye_colour,
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
};

const deleteUser = async (req, res) => {
    const { id } = req.params;  // Get the id from the request parameters

    try {
        // Query to delete the user from the database
        const [result] = await db.query('DELETE FROM users WHERE id = ?', [id]);

        // Check if any rows were affected (i.e., if the delete was successful)
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Respond with a success message
        res.status(200).json({ message: 'User deleted successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
};

module.exports = { register, login, update, getUserDetails, deleteUser };
