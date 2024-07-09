import asyncHandler from 'express-async-handler';
import { hash, verify } from 'argon2';
import { generateToken } from '../auth/generate-token.js';
import prisma from '../prisma.js';

// @desc     Register user
// @route    POST /auth/register
// @access   public
export const registerUser = asyncHandler(async (req, res) => {
    const { name, email, password, phone } = req.body;

    const isHaveUser = await prisma.user.findUnique({
        where: {
            email,
        },
    });

    if (isHaveUser) {
        res.status(400);
        throw new Error('Пользователь уже существует');
    }

    const user = await prisma.user.create({
        data: {
            email,
            password: await hash(password),
            name,
            phone,
        },
    });

    const token = generateToken(user.id);
    res.json({ user, token });
});
// @desc     Auth user
// @route    POST /auth/login
// @access   public
export const authUser = asyncHandler(async (req, res) => {
    const { email, password } = req.body;

    const user = await prisma.user.findUnique({
        where: {
            email,
        },
    });

    if (!user) {
        res.status(401);
        throw new Error('Пользователь не найден');
    }

    const isValidPassword = await verify(user.password, password);

    if (isValidPassword) {
        const token = generateToken(user.id);
        res.json({ user, token }); 
    } else {
        res.status(401);
        throw new Error('Почта и пароль не верны');
    }
});
