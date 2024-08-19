package me.bubble.bubble.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import me.bubble.bubble.config.jwt.JwtTokenProvider;
import me.bubble.bubble.domain.User;
import me.bubble.bubble.dto.*;
import me.bubble.bubble.service.AuthService;
import me.bubble.bubble.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RequiredArgsConstructor
@RestController
public class AuthApiController {
    private final AuthService authService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/api/auth/access")
    public ApiResponse<AccessTokenResponse> getAccessToken(@RequestBody AccessTokenRequest request) {
        if (request.getProvider().equals("KAKAO")) {
            String oAuthId = authService.getKakaoOAuthId(request.getCode(), request.getRedirect_uri());


            System.out.println("OAuthId"+ oAuthId);




            String accessToken = jwtTokenProvider.generateToken(oAuthId);
            System.out.println("AccessToken" + accessToken);
            AccessTokenResponse accessTokenResponse = new AccessTokenResponse(accessToken);

            return ApiResponse.<AccessTokenResponse>builder()
                    .code("OK")
                    .message("")
                    .data(accessTokenResponse)
                    .build();
//        }else if (request.getProvider().equals("GOOGLE")) {
//
//        }
        } else {
            return ApiResponse.<AccessTokenResponse>builder()
                    .code("NotKakao")
                    .message("")
                    .data(null)
                    .build();
        }
//        @GetMapping("/auth/logout")
//    public String logout (HttpServletRequest request, HttpServletResponse response) {
//        new SecurityContextLogoutHandler().logout(request, response,
//                SecurityContextHolder.getContext().getAuthentication());
//        return "redirect:/login";
//    }
    }
}
