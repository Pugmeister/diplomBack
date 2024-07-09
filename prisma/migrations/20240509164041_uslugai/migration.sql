/*
  Warnings:

  - You are about to drop the column `kolvo` on the `Complex` table. All the data in the column will be lost.
  - You are about to drop the column `cost` on the `Procedure` table. All the data in the column will be lost.
  - Added the required column `description` to the `Procedure` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Procedure` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `Procedure` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Complex" DROP COLUMN "kolvo";

-- AlterTable
ALTER TABLE "Procedure" DROP COLUMN "cost",
ADD COLUMN     "description" TEXT NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL,
ADD COLUMN     "price" INTEGER NOT NULL;
