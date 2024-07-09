import asyncHandler from 'express-async-handler'
import prisma from '../prisma.js'
import { UserFields } from '../utils/user.utils.js'

// @desc    Get user profile
// @route   GET /api/users/profile
// @access  Private
export const getUserProfile = asyncHandler(async (req, res) => {
    const userId = req.user.id; 

    const user = await prisma.user.findUnique({
        where: { id: userId },
        include: {
            profile: true,
            appointments: {
                include: {
                    procedure: true,
                    employee: true
                }
            }
        }
    });

    if (!user) {
        res.status(404);
        throw new Error('User not found');
    }

    res.json(user);
});

export const logoutUser = asyncHandler(async (req, res) => {

    res.status(200).json({ message: 'User logged out successfully' });
});
