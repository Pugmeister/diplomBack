// category.routes.js

import express from 'express';
import { protect } from '../middleware/auth.middleware.js';
import {
    createCategory,
    getCategories,
    getCategoryById,
    updateCategory,
    deleteCategory,
} from './category.controller.js';

const router = express.Router();
router.route('/category').post(protect, createCategory).get(getCategories);
router.route('/category/:id').get(getCategoryById).put(protect, updateCategory).delete(protect, deleteCategory);

export default router;
