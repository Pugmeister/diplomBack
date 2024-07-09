import express from 'express';
import { protect } from '../middleware/auth.middleware.js';
import {
    createReview,
    getReviews,
    getReviewById,
    updateReview,
    deleteReview,
} from './review.controller.js';

const router = express.Router();

router.use(protect);

router.route('/review').post(createReview).get(getReviews);
router
    .route('/review/:id')
    .get(getReviewById)
    .put(updateReview)
    .delete(deleteReview);

export default router;
