package com.sss.studycafe.admin.model.service;

import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.user.model.mapper.UserMapper;
import com.sss.studycafe.user.model.vo.User;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService{

    private final ResourceLoader resourceLoader;

    @Autowired
    private UserMapper userMapper;

    public AdminServiceImpl(ResourceLoader resourceLoader) {
        this.resourceLoader = resourceLoader;
    }

    @Override
    public void saveSeatMap(String map) {
        try {
            // 클래스패스 리소스를 로드
            Resource resource = resourceLoader.getResource("classpath:static/seatingmap.txt");

            // 클래스패스 리소스를 읽어옴
            byte[] contentBytes = FileCopyUtils.copyToByteArray(resource.getInputStream());
            String content = new String(contentBytes, StandardCharsets.UTF_8);

            // 파일에 쓰기
            File file = new File(resource.getURL().getPath());
            try (FileOutputStream fos = new FileOutputStream(file)) {
                fos.write(map.getBytes(StandardCharsets.UTF_8));
            }
        } catch (IOException e) {
            e.printStackTrace();
            // 예외 처리: 파일 쓰기 중에 오류가 발생한 경우
        }
    }

    @Override
    public List<User> getUsers(PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() - 1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return userMapper.selectUsers(rowBounds);
    }

    @Override
    public List<User> getUsers(PageInfo pageInfo, String keyword, String kind) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() - 1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return userMapper.selectUsersByKeywordAndKind(keyword, kind, rowBounds);
    }

    @Override
    public int releaseUser(List<String> targetUsers) {
        return userMapper.releaseUsers(targetUsers);
    }

    @Override
    public int suspendUser(List<String> targetUsers, int suspendDay) {
        // 현재 날짜와 시간을 가져옴
        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

        // suspendDay를 밀리초로 변환하여 더함
        long millisecondsToAdd = suspendDay * 24 * 60 * 60 * 1000L; // 하루는 24시간, 1시간은 60분, 1분은 60초, 1초는 1000밀리초
        Timestamp suspendedTimestamp = new Timestamp(currentTimestamp.getTime() + millisecondsToAdd);

        System.out.println(targetUsers);
        System.out.println(suspendedTimestamp);

        return userMapper.suspendUsers(targetUsers, suspendedTimestamp);
    }

    @Override
    public String[] calWeeks(Date current) {

        String[] result = new String[12];

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(current);


        for(int i = 0; i < 12; i++){
            int month = calendar.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 +1 해줍니다.
            int weekOfMonth = calendar.get(Calendar.WEEK_OF_MONTH);

            result[i]  = month + "월" + weekOfMonth + "주";
            calendar.add(Calendar.DAY_OF_MONTH, -7);
        }


        return result;
    }
}
