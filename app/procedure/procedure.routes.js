import express from 'express';
import { protect } from '../middleware/auth.middleware.js';
import { createProcedure, getProcedures, getProcedureById, updateProcedure, deleteProcedure } from './procedure.controller.js';

const router = express.Router();

router.route('/procedures').post(protect, createProcedure).get(getProcedures)
router.route('/procedures/:id').get(getProcedureById)
router.route('/procedures/:id').put(protect, updateProcedure)
router.route('/procedures/:id').delete(protect, deleteProcedure)
router.route('/procedures/:id').patch(protect,updateProcedure)

export default router;
