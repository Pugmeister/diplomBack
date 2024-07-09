-- CreateTable
CREATE TABLE "Spa" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "images" TEXT[],
    "name" TEXT[],
    "cost" INTEGER NOT NULL,
    "kolvo" INTEGER NOT NULL,

    CONSTRAINT "Spa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Fitness" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "images" TEXT[],
    "name" TEXT[],
    "cost" INTEGER NOT NULL,
    "kolvo" INTEGER NOT NULL,

    CONSTRAINT "Fitness_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Medicene" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "images" TEXT[],
    "name" TEXT[],
    "cost" INTEGER NOT NULL,
    "kolvo" INTEGER NOT NULL,

    CONSTRAINT "Medicene_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Beaty" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "images" TEXT[],
    "name" TEXT[],
    "cost" INTEGER NOT NULL,
    "kolvo" INTEGER NOT NULL,

    CONSTRAINT "Beaty_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ProcedureToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_ProcedureToSpa" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_FitnessToProcedure" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_MediceneToProcedure" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_BeatyToProcedure" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ProcedureToUser_AB_unique" ON "_ProcedureToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_ProcedureToUser_B_index" ON "_ProcedureToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ProcedureToSpa_AB_unique" ON "_ProcedureToSpa"("A", "B");

-- CreateIndex
CREATE INDEX "_ProcedureToSpa_B_index" ON "_ProcedureToSpa"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_FitnessToProcedure_AB_unique" ON "_FitnessToProcedure"("A", "B");

-- CreateIndex
CREATE INDEX "_FitnessToProcedure_B_index" ON "_FitnessToProcedure"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_MediceneToProcedure_AB_unique" ON "_MediceneToProcedure"("A", "B");

-- CreateIndex
CREATE INDEX "_MediceneToProcedure_B_index" ON "_MediceneToProcedure"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_BeatyToProcedure_AB_unique" ON "_BeatyToProcedure"("A", "B");

-- CreateIndex
CREATE INDEX "_BeatyToProcedure_B_index" ON "_BeatyToProcedure"("B");

-- AddForeignKey
ALTER TABLE "_ProcedureToUser" ADD CONSTRAINT "_ProcedureToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Procedure"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProcedureToUser" ADD CONSTRAINT "_ProcedureToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProcedureToSpa" ADD CONSTRAINT "_ProcedureToSpa_A_fkey" FOREIGN KEY ("A") REFERENCES "Procedure"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProcedureToSpa" ADD CONSTRAINT "_ProcedureToSpa_B_fkey" FOREIGN KEY ("B") REFERENCES "Spa"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FitnessToProcedure" ADD CONSTRAINT "_FitnessToProcedure_A_fkey" FOREIGN KEY ("A") REFERENCES "Fitness"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FitnessToProcedure" ADD CONSTRAINT "_FitnessToProcedure_B_fkey" FOREIGN KEY ("B") REFERENCES "Procedure"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MediceneToProcedure" ADD CONSTRAINT "_MediceneToProcedure_A_fkey" FOREIGN KEY ("A") REFERENCES "Medicene"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MediceneToProcedure" ADD CONSTRAINT "_MediceneToProcedure_B_fkey" FOREIGN KEY ("B") REFERENCES "Procedure"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BeatyToProcedure" ADD CONSTRAINT "_BeatyToProcedure_A_fkey" FOREIGN KEY ("A") REFERENCES "Beaty"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BeatyToProcedure" ADD CONSTRAINT "_BeatyToProcedure_B_fkey" FOREIGN KEY ("B") REFERENCES "Procedure"("id") ON DELETE CASCADE ON UPDATE CASCADE;
