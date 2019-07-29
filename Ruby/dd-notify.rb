require 'json'
require 'httparty'

# 钉钉通知,参考xu.ke代码.hh
class DDNotify
    
    @@Mobiles = {
        'zhibin.xiao' => '18814803658'
    }

    @@Tokens = {
        'ios' => '',
        'android' => ''
    }

    @@DDUrl = "https://oapi.dingtalk.com/robot/send?access_token="

    def self.do_post uri, body
        resp = HTTParty.post uri,
                            :body => body,
                            :headers => {
                                'Content-Type' => 'application/json'
                            }
        if data = JSON.parse(resp.body)
        if data['errcode'] == 0
            puts "通知发送成功"
        else
            puts "通知发送失败 #{resp.body}"
        end
        else
            puts "通知发送失败，服务器无响应"
        end
    end

    #DD-Doc: https://open-doc.dingtalk.com/microapp/serverapi2/qf2nxq
    def self.post(msg, group: 'ios', at: [], link:, token:nil, firlink:)
        if msg.nil?
            return
        end
        #获取token
        if token.nil?
            if token = @@Tokens[group]
                uri = "#{@@DDUrl}#{token}"
            else
                return puts "group#{group} not found."
            end
        else
            uri = "#{@@DDUrl}#{token}"
        end
        #确定@范围
        if at == 'all' or at.include? "all"
            # text = '@所有人'
            atMobiles = [],
            isAtAll = true
        else
            atMobiles = at.map do |name|
                @@Mobiles[name]
            end.select do |mobile|
                mobile
            end
            #通知text
            text = atMobiles.map do | mobile |
                "@#{mobile}"
            end.join ' '
            
            text = at.map do |name|
                "@#{name}<手机号未配置>"
            end.join(' ') if text.empty?

            isAtAll = false
          
        end

        unless firlink.empty?
            msg = "#{msg}\nfir : #{firlink}"
        end

        timetext = Time.new.strftime("%Y-%m-%d %H:%M");
        text = "#{timetext}\n#{msg} #{text}\n"

        puts text
        content = {
            'msgtype' => 'text',
            'text' => {
                'content' => text,
            },
            'at' => {
                'atMobiles' => atMobiles,
                'isAtAll' => isAtAll,
            }
        }.to_json
        self.do_post uri, content
    end

end
