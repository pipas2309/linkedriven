CREATE TABLE "public.users" (
	"user_id" serial NOT NULL,
	"name" TEXT(64) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("user_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.products" (
	"product_id" serial NOT NULL,
	"category_id" serial NOT NULL,
	"size_id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"price" integer NOT NULL,
	"image" json NOT NULL,
	"quatity_stock" DECIMAL NOT NULL,
	CONSTRAINT "products_pk" PRIMARY KEY ("product_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.cart_list" (
	"cart_list_id" serial NOT NULL,
	"product_id" serial NOT NULL,
	"amount" DECIMAL NOT NULL,
	CONSTRAINT "cart_list_pk" PRIMARY KEY ("cart_list_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.product_categories" (
	"category_id" serial NOT NULL,
	"category_name" TEXT NOT NULL UNIQUE,
	CONSTRAINT "product_categories_pk" PRIMARY KEY ("category_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.product_sizes" (
	"size_id" serial NOT NULL,
	"size_name" TEXT NOT NULL UNIQUE,
	CONSTRAINT "product_sizes_pk" PRIMARY KEY ("size_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.purchases_historic" (
	"historic_id" serial NOT NULL,
	"user_id" serial NOT NULL,
	"purchase_id" serial NOT NULL,
	CONSTRAINT "purchases_historic_pk" PRIMARY KEY ("historic_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.cart" (
	"cart_id" serial NOT NULL,
	"user_id" serial NOT NULL,
	"cart_list_id" serial NOT NULL,
	"coupon" TEXT,
	"cart_total_price" integer,
	CONSTRAINT "cart_pk" PRIMARY KEY ("cart_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.purchases" (
	"purchase_id" serial NOT NULL,
	"user_id" serial NOT NULL,
	"cart_id" serial NOT NULL,
	"TYPE: status" TEXT NOT NULL UNIQUE,
	"purchase_date" DATE NOT NULL DEFAULT 'NOW()',
	CONSTRAINT "purchases_pk" PRIMARY KEY ("purchase_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.all_sales" (
	"all_sales_id" serial NOT NULL,
	"historic_id" serial NOT NULL,
	"issue_date" DATE NOT NULL,
	"gross_total_amount" integer NOT NULL,
	"total_net_value" integer NOT NULL,
	"total_purchases" integer NOT NULL,
	"total_canceled_purchases" integer NOT NULL,
	CONSTRAINT "all_sales_pk" PRIMARY KEY ("all_sales_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.user_details" (
	"user_details_id" serial NOT NULL,
	"user_id" serial NOT NULL,
	"address" TEXT,
	"landline" DECIMAL,
	"cell_phone" DECIMAL,
	CONSTRAINT "user_details_pk" PRIMARY KEY ("user_details_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.coupons" (
	"coupon_id" serial NOT NULL,
	"coupon_name" TEXT NOT NULL,
	"coupon_discount" integer NOT NULL DEFAULT '0',
	"coupon_message" TEXT,
	CONSTRAINT "coupons_pk" PRIMARY KEY ("coupon_id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "products" ADD CONSTRAINT "products_fk0" FOREIGN KEY ("category_id") REFERENCES "product_categories"("category_id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk1" FOREIGN KEY ("size_id") REFERENCES "product_sizes"("size_id");

ALTER TABLE "cart_list" ADD CONSTRAINT "cart_list_fk0" FOREIGN KEY ("product_id") REFERENCES "products"("product_id");



ALTER TABLE "purchases_historic" ADD CONSTRAINT "purchases_historic_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("user_id");
ALTER TABLE "purchases_historic" ADD CONSTRAINT "purchases_historic_fk1" FOREIGN KEY ("purchase_id") REFERENCES "purchases"("purchase_id");

ALTER TABLE "cart" ADD CONSTRAINT "cart_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("user_id");
ALTER TABLE "cart" ADD CONSTRAINT "cart_fk1" FOREIGN KEY ("cart_list_id") REFERENCES "cart_list"("cart_list_id");

ALTER TABLE "purchases" ADD CONSTRAINT "purchases_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("user_id");
ALTER TABLE "purchases" ADD CONSTRAINT "purchases_fk1" FOREIGN KEY ("cart_id") REFERENCES "cart"("cart_id");

ALTER TABLE "all_sales" ADD CONSTRAINT "all_sales_fk0" FOREIGN KEY ("historic_id") REFERENCES "purchases_historic"("historic_id");

ALTER TABLE "user_details" ADD CONSTRAINT "user_details_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("user_id");













