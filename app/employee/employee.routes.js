import express from 'express';
import { getEmployees, createEmployee } from './employee.controller.js'; 
const router = express.Router();

router.get('/employee', getEmployees);
router.post('/employee', createEmployee);

export default router;
