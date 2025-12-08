import { InputType, Field, registerEnumType } from '@nestjs/graphql';

enum Role {
  USER = 'USER',
  ADMIN = 'ADMIN',
  SUPER_ADMIN = 'SUPER_ADMIN',
}

registerEnumType(Role, {
  name: 'Role',
});

@InputType()
export class CreateUserInput {
  @Field({ nullable: true })
  firstName: string;

  @Field({ nullable: true })
  lastName: string;

  @Field()
  email: string;

  @Field(() => Role)
  role: Role;

  @Field()
  password: string;

  @Field()
  isEmailVerified: boolean;

  @Field()
  isNewsletterSubscribed: boolean;
}
