package com.sss.studycafe.common.model.service;

import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

@Service
public class CommonServiceImpl implements CommonService{
    @Override
    public String[] getSeatingChart() {
        InputStream inputStream = getClass().getClassLoader().getResourceAsStream("static/seatingmap.txt");

        // 읽어온 내용을 저장할 문자열 변수
        StringBuilder content = new StringBuilder();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 문자열을 한 글자씩 분할하여 배열로 저장
        String[] contentArray = content.toString().split("[ \n]+");

        return contentArray;
    }
}
