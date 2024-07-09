import asyncHandler from 'express-async-handler';
import prisma from '../prisma.js';

export const createReview = asyncHandler(async (req, res) => {
    const { userId, procedureId, rating, comment, appointmentId } = req.body;

    const existingReview = await prisma.review.findFirst({
        where: {
            userId,
            procedureId,
            appointmentId
        },
    });

    if (existingReview) {
        res.status(400);
        throw new Error('Вы уже оставили отзыв для этой услуги.');
    }

    const review = await prisma.review.create({
        data: {
            userId,
            procedureId,
            rating,
            comment,
            appointmentId,
        },
    });

    res.status(201).json(review);
});

export const getReviews = asyncHandler(async (req, res) => {
    const reviews = await prisma.review.findMany();
    res.json(reviews);
});

export const getReviewById = asyncHandler(async (req, res) => {
    const { id } = req.params;

    const review = await prisma.review.findUnique({
        where: {
            id: parseInt(id),
        },
    });

    if (!review) {
        res.status(404);
        throw new Error('Review not found');
    }

    res.json(review);
});

export const updateReview = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { rating, comment } = req.body;

    const review = await prisma.review.update({
        where: {
            id: parseInt(id),
        },
        data: {
            rating,
            comment,
        },
    });

    res.json(review);
});

export const deleteReview = asyncHandler(async (req, res) => {
    const { id } = req.params;

    await prisma.review.delete({
        where: {
            id: parseInt(id),
        },
    });

    res.json({ message: 'Review removed' });
});
