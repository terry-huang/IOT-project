package com.deer.controller;

import com.deer.domain.User;
import com.deer.service.UserService;
import com.deer.vo.QueryUserCondition;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/user/account")
public class UserAccountController {

    private final int pageMax = 5;

    @Resource
    private UserService userService;

    /**
     * 注册
     * @param user 用户信息
     * @return 注册结果
     */
    @RequestMapping(value = "/registerUser.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> registerUser(User user){
        Map<String,Object> map = new HashMap<>();
        int result = userService.registerUser(user);
        if (result==1){
            map.put("msg","注册成功");
            map.put("tag",1);
        }else if (result==0){
            map.put("msg", "用户名已存在，请重新注册");
            map.put("tag", 0);
        }else{
            map.put("msg","注册失败，请重新注册");
            map.put("tag",2);
        }
        return map;
    }

    /**
     * 登录
     * @param name 用户名
     * @param password 密码
     * @param request 网络请求
     * @return 登陆结果
     */
    @RequestMapping(value = "/loginUser.do",method = RequestMethod.POST)
    @ResponseBody
    public String loginUser(String name, String password, HttpServletRequest request, HttpServletResponse response){
        Map<Object,Object> map = new HashMap<>();
        HttpSession session = request.getSession();
        if (userService.loginUser(name,password)){
            int ID = userService.queryOneUserIDByNamePassword(name,password);
            int priority =userService.queryOneUserPriorityByID(ID);
            session.setAttribute("ID",ID);
            session.setAttribute("priority",priority);
            return "0";
        }else{
            return "1";
        }
        /*Cookie cookie1 = new Cookie("name", name);
        Cookie cookie2 = new Cookie("password", password);
        response.addCookie(cookie1);
        response.addCookie(cookie2);*/
    }

    /**
     * 删除用户
     * @param ID 用户的ID
     * @return 删除结果
     */
    @RequestMapping(value = "/deleteUser.do")
    public ModelAndView deleteUser(int ID, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            mv.addObject("msg", "该用户没有权限");
            mv.setViewName("/result.jsp");
            return mv;
        }
        int num = userService.deleteUser(ID);
        if (num == 1) {
            mv.addObject("msg", "删除成功");
        }else if (num == 0){
            mv.addObject("msg","删除失败，请稍后重试");
        }else if (num == 2){
            mv.addObject("msg", "删除失败，该用户仍持有卡片，请回收卡片再进行删除");
        }
        mv.setViewName("/result.jsp");
        return mv;
    }

    /**
     * 修改密码
     * @param session 用户在本地的仓库
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @return 修改结果
     */
    @RequestMapping(value = "/updateUserPassword.do",method = RequestMethod.POST,produces = "application/json;charset=UTF-8")
    @ResponseBody
    public Map<String,Object> updateUserPassword(HttpSession session, String oldPassword, String newPassword){
        Map<String,Object> map = new HashMap();
        String msg = null;
        Integer ID = (Integer) session.getAttribute("ID");
        String pwd = userService.queryOneUserByID(ID).getPassword();
        if (oldPassword.equals(pwd)){
            int num = userService.updateUserPassword(ID,newPassword);
            if (num == 1){
                msg = "密码修改成功，当前密码为"+newPassword;
            }else{
                msg = "密码修改失败，请稍后尝试";
            }
        }else{
            msg = "查无此用户，无法修改密码";
        }
        map.put("msg", msg);
        return map;
    }

    /**
     * 获取用户资料
     * @param session 用户在本地的仓库
     * @return 用户信息
     */
    @RequestMapping(value = "/queryOneUserAllInfo.do")
    public ModelAndView queryOneUserAllInfoByID(HttpSession session){
        ModelAndView mv = new ModelAndView();
        Integer ID = (Integer) session.getAttribute("ID");
        User user = userService.queryOneUserByID(ID);
        mv.addObject("user", user);
        mv.addObject("status", (user.getStatus()==1?"正常":"停用"));
        mv.setViewName("/mainPage/profile.jsp");
        return mv;
    }

    /**
     * 退出登录
     * @param session 用户的本地仓库
     * @return 登录界面
     */
    @RequestMapping(value = "/loginOutUser.do")
    public ModelAndView loginOutUser(HttpSession session){
        ModelAndView mv = new ModelAndView();
        session.removeAttribute("ID");
        session.removeAttribute("priority");
        mv.setViewName("/mainPage/login.jsp");
        return mv;
    }

    /**
     * 查询所有用户的信息
     * @param session 用户在本地的仓库
     * @return userList
     */
    @RequestMapping(value = "/queryAllUserInfo.do")
    public ModelAndView queryAllUserInfo(HttpSession session, int page){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            mv.addObject("msg", "该用户没有权限");
            mv.setViewName("/result.jsp");
            return mv;
        }
        Map<String,Object> map = userService.queryAllUserInfo(page);
        mv.addObject("maxPage", map.get("maxPage"));
        mv.addObject("page", page);
        mv.addObject("action", "user/account/queryAllUserInfo.do");
        mv.addObject("userList", map.get("userList"));
        mv.addObject("pageMax", pageMax);
        mv.setViewName("/logManagement/userLog.jsp");
        return mv;
    }

    /**
     * 高级查询
     * @param session 用户在本地的仓库
     * @param queryUserCondition 查询条件
     * @param page 页数
     * @return 根据查询条件搜索出来的用户
     */
    @RequestMapping(value = "/queryAllUserInfoByCondition.do")
    public ModelAndView queryAllUserInfoByCondition(HttpSession session, QueryUserCondition queryUserCondition, int page){
        ModelAndView mv = new ModelAndView();
        int ID = (int) session.getAttribute("ID");
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            mv.addObject("msg", "该用户没有权限");
            mv.setViewName("/result.jsp");
            return mv;
        }
        Map<String,Object> map = userService.queryAllUserInfoByCondition(queryUserCondition, page);
        if (((List<User>) map.get("userList")).size() == 0){
            page = 1;
            map = userService.queryAllUserInfoByCondition(queryUserCondition, page);
        }
        mv.addObject("maxPage", map.get("maxPage"));
        mv.addObject("page", page);
        mv.addObject("action", "user/account/queryAllUserInfoByCondition.do");
        mv.addObject("userList", map.get("userList"));
        mv.addObject("pageMax", pageMax);
        mv.addObject("queryUserCondition", queryUserCondition);
        mv.setViewName("/logManagement/userLogSearch.jsp");
        return mv;
    }

    /**
     * 根据ID获取用户详情
     * @param ID 用户ID
     * @return 用户信息
     */
    @RequestMapping(value = "/queryOneUserDetailInfo.do")
    @ResponseBody
    public Map<String,Object> queryOneUserDetailInfo(int ID){
        Map<String,Object> map = new HashMap<>();
        User user = userService.queryOneUserByID(ID);
        map.put("user", user);
        map.put("status", (user.getStatus()==1?"正常":"停用"));
        return map;
    }


    /**
     * 搜索一个用户的信息
     * @param ID ID
     * @param session 用户在本地的仓库
     * @return user
     */
    @RequestMapping(value = "/queryOneUserBeforeUpdate.do")
    public ModelAndView queryOneUserBeforeUpdate(int ID, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            mv.addObject("msg", "该用户没有权限");
            mv.setViewName("/result.jsp");
            return mv;
        }
        User user = userService.queryOneUserByID(ID);
        mv.addObject("user", user);
        mv.setViewName("/logManagement/userLogChange.jsp");
        return mv;
    }

    /**
     * 更新一个用户信息
     * @param user 用户信息
     * @param session 用户在本地的仓库
     * @return 修改结果
     */
    @RequestMapping(value = "/updateOneUserAllInfo.do")
    public ModelAndView updateOneUserAllInfo(User user, HttpSession session){
        ModelAndView mv = new ModelAndView();
        int priority = (int) session.getAttribute("priority");
        if (priority==1){
            mv.addObject("msg", "该用户没有权限");
            mv.setViewName("/result.jsp");
            return mv;
        }
        int num = userService.updateOneUserAllInfo(user);
        if (num == 1){
            mv.addObject("msg", "用户信息更新成功");
        }else{
            mv.addObject("msg", "用户信息更新失败！请稍后重试");
        }
        mv.setViewName("/result.jsp");
        return mv;
    }
}
