import { InputType, Field } from '@nestjs/graphql';

@InputType()
export class CreateUserInput {
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
}
