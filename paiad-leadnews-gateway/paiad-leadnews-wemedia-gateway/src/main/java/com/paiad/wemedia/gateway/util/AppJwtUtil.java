package com.paiad.wemedia.gateway.util;

import io.jsonwebtoken.*;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.*;

public class AppJwtUtil {

    // TOKEN的有效期一天（S�?
    private static final int TOKEN_TIME_OUT = 3_600;
    // 加密KEY
    private static final String TOKEN_ENCRY_KEY = "MDk4ZjZiY2Q0NjIxZDM3M2NhZGU0ZTgzMjYyN2I0ZjY";
    // 最小刷新间�?S)
    private static final int REFRESH_TIME = 300;

    // 生产ID
    public static String getToken(Long id) {
        Map<String, Object> claimMaps = new HashMap<>();
        claimMaps.put("id", id);
        long currentTime = System.currentTimeMillis();
        return Jwts.builder()
                .setId(UUID.randomUUID().toString())
                .setIssuedAt(new Date(currentTime))  //签发时间
                .setSubject("system")  //说明
                .setIssuer("heima") //签发者信�?
                .setAudience("app")  //接收用户
                .compressWith(CompressionCodecs.GZIP)  //数据压缩方式
                .signWith(SignatureAlgorithm.HS512, generalKey()) //加密方式
                .setExpiration(new Date(currentTime + TOKEN_TIME_OUT * 1000))  //过期时间�?
                .addClaims(claimMaps) //cla信息
                .compact();
    }

    /**
     * 获取token中的claims信息
     *
     * @param token
     * @return
     */
    private static Jws<Claims> getJws(String token) {
        return Jwts.parser()
                .setSigningKey(generalKey())
                .parseClaimsJws(token);
    }

    /**
     * 获取payload body信息
     *
     * @param token
     * @return
     */
    public static Claims getClaimsBody(String token) throws ExpiredJwtException {
        return getJws(token).getBody();
    }

    /**
     * 获取hearder body信息
     *
     * @param token
     * @return
     */
    public static JwsHeader getHeaderBody(String token) {
        return getJws(token).getHeader();
    }

    /**
     * 是否过期
     *
     * @param claims
     * @return -1：有效，0：有效，1：过期，2：过�?
     */
    public static int verifyToken(Claims claims) throws Exception {
        if (claims == null) {
            return 1;
        }

        claims.getExpiration().before(new Date());
        // 需要自动刷新TOKEN
        if ((claims.getExpiration().getTime() - System.currentTimeMillis()) > REFRESH_TIME * 1000) {
            return -1;
        } else {
            return 0;
        }
    }

    /**
     * 由字符串生成加密key
     *
     * @return
     */
    public static SecretKey generalKey() {
        byte[] encodedKey = Base64.getEncoder().encode(TOKEN_ENCRY_KEY.getBytes());
        SecretKey key = new SecretKeySpec(encodedKey, 0, encodedKey.length, "AES");
        return key;
    }

    public static void main(String[] args) {
       /* Map map = new HashMap();
        map.put("id","11");*/
        System.out.println(AppJwtUtil.getToken(1102L));
        Jws<Claims> jws = AppJwtUtil.getJws("eyJhbGciOiJIUzUxMiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAAADWLQQqEMAwA_5KzhURNt_qb1KZYQSi0wi6Lf9942NsMw3zh6AVW2DYmDGl2WabkZgreCaM6VXzhFBfJMcMARTqsxIG9Z888QLui3e3Tup5Pb81013KKmVzJTGo11nf9n8v4nMUaEY73DzTabjmDAAAA.4SuqQ42IGqCgBai6qd4RaVpVxTlZIWC826QA9kLvt9d-yVUw82gU47HDaSfOzgAcloZedYNNpUcd18Ne8vvjQA");
        Claims claims = jws.getBody();
        System.out.println(claims.get("id"));

    }

}
