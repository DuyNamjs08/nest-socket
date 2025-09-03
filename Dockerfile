# -------- Development stage --------
FROM node:20-alpine AS development

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build
RUN npx prisma generate

# -------- Production stage --------
FROM node:20-alpine AS production

WORKDIR /usr/src/app

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

ARG PORT=8085
ENV PORT=${PORT}

COPY package*.json ./
RUN npm ci --only=production

COPY --from=development /usr/src/app/dist ./dist
COPY --from=development /usr/src/app/node_modules/.prisma ./node_modules/.prisma
COPY --from=development /usr/src/app/prisma ./prisma

EXPOSE ${PORT}

CMD ["node", "dist/main"]
