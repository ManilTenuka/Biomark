// routes/index.js
const express = require('express');
const router = express.Router();
const auth = require('./controller')
router.get('/', (req, res) => {
    res.send('Welcome to the Home Route!');
});

router.post('/register',  auth.register);
router.post('/login', auth.login);
router.put('/update',auth.update);
router.get('/view/:id', auth.getUserDetails); 
router.delete('/delete/:id', auth.deleteUser); 



module.exports = router;
