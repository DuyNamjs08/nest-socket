import { Controller, Get, UseGuards, Req } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from 'src/prisma/prisma.service';
import { Public } from 'src/decorators/public.decorator';


@Controller('auth')
export class AuthController {
    constructor(
        private readonly prisma: PrismaService,
        private readonly jwtService: JwtService,
    ) { }
    @Public()
    @Get('google')
    @UseGuards(AuthGuard('google'))
    async googleLogin() {
        // redirect sang Google
    }

    @Public()
    @Get('google/callback')
    @UseGuards(AuthGuard('google'))
    async googleCallback(@Req() req) {
        const profile = req.user;
        let socialAccount = await this.prisma.social_accounts.findFirst({
            where: {
                provider: 'google',
                provider_user_id: profile.providerUserId,
            },
            include: { users: true },
        });
        let user;
        if (!socialAccount) {
            // Tạo user mới + social_account
            user = await this.prisma.users.create({
                data: {
                    email: profile.email,
                    name: profile.name,
                    avatar: profile.avatar,
                    social_accounts: {
                        create: {
                            provider: 'google',
                            provider_user_id: profile.providerUserId,
                            access_token: profile.accessToken,
                        },
                    },
                },
            });
        } else {
            user = socialAccount.users;
        }
        const payload = { sub: user.id, email: user.email };
        const token = this.jwtService.sign(payload);

        return { user, access_token: token };
    }
}
