/*
  Warnings:

  - You are about to drop the column `endTime` on the `BookedSlot` table. All the data in the column will be lost.
  - You are about to drop the column `endTime` on the `Schedule` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "BookedSlot" DROP COLUMN "endTime";

-- AlterTable
ALTER TABLE "Schedule" DROP COLUMN "endTime";
