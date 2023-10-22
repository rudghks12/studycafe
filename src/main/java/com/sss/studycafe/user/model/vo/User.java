package com.sss.studycafe.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User implements UserDetails {
    private String id;

    private String email;

    private String password;

    private String name;

    private String nickname;

    private String phone;

    private String image;

    private String role;

    private String status;

    private int mileage;

    private int fixed;

    private int locker;

    private Date createDate;

    private Date updateDate;

    private Date releaseDate;

    @Override
    public String getUsername() {

        return this.email;
    }

    @Override
    public String getPassword() {

        return this.password;
    }

    // 계정의 권한의 목록을 리턴한다.
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<>();

        authorities.add(new SimpleGrantedAuthority(this.role));

        return authorities;
    }

    // 계정 만료 여부 (false - 만료)
    @Override
    public boolean isAccountNonExpired() {

        return true;
    }

    // 계정 잠김 여부 (false - 잠김)
    @Override
    public boolean isAccountNonLocked() {
        Date today = new Date(System.currentTimeMillis());

        System.out.println("release: " + this.releaseDate);

        return this.releaseDate == null || this.releaseDate.before(today);
    }

    // 패스워드 만료 여부 (false - 만료)
    @Override
    public boolean isCredentialsNonExpired() {

        return true;
    }

    // 계정 활성화 여부 (false - 비활성화)
    @Override
    public boolean isEnabled() {

        return this.status.equals("Y");
    }
}
