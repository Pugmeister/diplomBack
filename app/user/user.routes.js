import express from 'express'

import { protect } from '../middleware/auth.middleware.js'

import { getUserProfile, logoutUser } from './user.controller.js'

const router = express.Router()

router.route('/profile').get(protect, getUserProfile)
router.post('/logout', logoutUser); 

export default router
