import express from 'express';
import { 
    createPayment, 
    getPayments, 
    getPaymentById, 
    updatePayment, 
    deletePayment } from '../payment/payment.controller.js';

const router = express.Router();

router.route('/payment').get(getPayments).post(createPayment);
router.route('/payment/:id').get(getPaymentById).put(updatePayment).delete(deletePayment);

export default router;
