/*
  Warnings:

  - You are about to drop the column `user_id_fk` on the `UserPrefrence` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "UserPrefrence_user_id_fk_key";

-- AlterTable
ALTER TABLE "UserPrefrence" DROP COLUMN "user_id_fk";
