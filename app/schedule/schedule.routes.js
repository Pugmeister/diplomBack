import express from 'express';
import { 
    getSchedulesByEmployee, 
    getAllSchedulesByEmployee,
    createSchedule, 
    updateSchedule, 
    deleteSchedule, 
    deleteDaySchedule,
    bookScheduleSlot 
} from '../schedule/schedule.controller.js';

const router = express.Router();

router.get('/employee/:employeeId/schedule', getSchedulesByEmployee);
router.get('/employee/:employeeId/all-schedules', getAllSchedulesByEmployee);
router.post('/schedule', createSchedule);
router.put('/schedule/:id', updateSchedule);
router.delete('/schedule/:id', deleteSchedule);
router.delete('/schedule/day/:employeeId', deleteDaySchedule); 
router.post('/schedule/book', bookScheduleSlot);

export default router;
