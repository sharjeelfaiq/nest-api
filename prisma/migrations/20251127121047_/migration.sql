-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN', 'SUPER_ADMIN');

-- CreateEnum
CREATE TYPE "ContentStatus" AS ENUM ('DRAFT', 'PUBLISHED', 'ARCHIVED');

-- CreateTable
CREATE TABLE "Admin" (
    "id" UUID NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "permissions" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "lastEditedBy" VARCHAR(255),
    "role" "Role" NOT NULL DEFAULT 'ADMIN',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" UUID NOT NULL,
    "firstName" VARCHAR(100) NOT NULL,
    "lastName" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "isEmailVerified" BOOLEAN NOT NULL DEFAULT false,
    "isNewsletterSubscribed" BOOLEAN NOT NULL DEFAULT false,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" UUID NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "shortDescription" VARCHAR(255),
    "slug" VARCHAR(255),
    "metaTitle" VARCHAR(70),
    "metaDescription" VARCHAR(160),
    "canonicalTag" VARCHAR(255),
    "breadcrumb" VARCHAR(255),
    "posterImageUrl" VARCHAR(512),
    "seoSchema" TEXT,
    "lastEditedBy" VARCHAR(255),
    "status" "ContentStatus" NOT NULL DEFAULT 'PUBLISHED',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subcategory" (
    "id" UUID NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "shortDescription" VARCHAR(255),
    "slug" VARCHAR(255),
    "metaTitle" VARCHAR(70),
    "metaDescription" VARCHAR(160),
    "canonicalTag" VARCHAR(255),
    "breadcrumb" VARCHAR(255),
    "posterImageUrl" VARCHAR(512),
    "seoSchema" TEXT,
    "categoryId" UUID NOT NULL,
    "lastEditedBy" VARCHAR(255),
    "status" "ContentStatus" NOT NULL DEFAULT 'PUBLISHED',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Subcategory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" UUID NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "shortDescription" VARCHAR(255),
    "slug" VARCHAR(255) NOT NULL,
    "metaTitle" VARCHAR(120),
    "metaDescription" VARCHAR(160),
    "canonicalTag" VARCHAR(255),
    "breadcrumb" VARCHAR(255),
    "posterImageUrl" VARCHAR(512) NOT NULL,
    "seoSchema" TEXT,
    "productImages" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "price" DECIMAL(65,30) NOT NULL DEFAULT 0,
    "discountPrice" DECIMAL(65,30) DEFAULT 0,
    "stock" INTEGER NOT NULL DEFAULT 0,
    "height" DECIMAL(65,30) DEFAULT 0,
    "width" DECIMAL(65,30) DEFAULT 0,
    "weight" DECIMAL(65,30) DEFAULT 0,
    "color" VARCHAR(100),
    "pattern" VARCHAR(100),
    "composition" VARCHAR(255),
    "isMotorized" BOOLEAN NOT NULL DEFAULT false,
    "additionalInfo" TEXT,
    "measuringGuide" TEXT,
    "categoryId" UUID NOT NULL,
    "subcategoryId" UUID NOT NULL,
    "lastEditedBy" VARCHAR(255),
    "status" "ContentStatus" NOT NULL DEFAULT 'PUBLISHED',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- CreateIndex
CREATE INDEX "Admin_email_idx" ON "Admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE INDEX "Category_name_idx" ON "Category"("name");

-- CreateIndex
CREATE INDEX "Category_slug_idx" ON "Category"("slug");

-- CreateIndex
CREATE INDEX "Subcategory_categoryId_idx" ON "Subcategory"("categoryId");

-- CreateIndex
CREATE INDEX "Subcategory_slug_idx" ON "Subcategory"("slug");

-- CreateIndex
CREATE INDEX "Product_name_idx" ON "Product"("name");

-- CreateIndex
CREATE INDEX "Product_categoryId_idx" ON "Product"("categoryId");

-- CreateIndex
CREATE INDEX "Product_subcategoryId_idx" ON "Product"("subcategoryId");

-- CreateIndex
CREATE INDEX "Product_price_idx" ON "Product"("price");

-- CreateIndex
CREATE INDEX "Product_slug_idx" ON "Product"("slug");

-- AddForeignKey
ALTER TABLE "Subcategory" ADD CONSTRAINT "Subcategory_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_subcategoryId_fkey" FOREIGN KEY ("subcategoryId") REFERENCES "Subcategory"("id") ON DELETE CASCADE ON UPDATE CASCADE;
