import { ObjectType, Field, ID } from '@nestjs/graphql';

@ObjectType()
export class User {
  @Field(() => ID)
  id: string;

  @Field({ nullable: true })
  firstName: string;

  @Field({ nullable: true })
  lastName: string;

  @Field()
  email: string;

  @Field()
  role: string;

  @Field()
  password: string;

  @Field()
  isEmailVerified?: boolean;

  @Field()
  isNewsletterSubscribed?: boolean;

  @Field()
  createdAt: Date;

  @Field()
  updatedAt: Date;
}
