import YQ from './yq/yq';
export default class ConfigMgr {
    loadConf() {
        YQ.get('data.json', null, (data: XMLHttpRequest | null, status: number) => {
            const strNoData: string = '未能成功获取配置数据 ';
            if (status != 200) {
                alert(strNoData + status.toString());
                return;
            }
            if (data == null) {
                alert(strNoData);
                return;
            }
            const textData: string = data.responseText;
            if (textData.length < 10) {
                alert(strNoData);
                return;
            }
            const json: object = JSON.parse(textData);
            window.g_confdata = json;
            console.log(window.g_confdata);
            this.showTitle();
            this.showList();
        });
    }

    showTitle() {
        const title: string = window.g_confdata.title;
        document.title = title;
        const titleDiv: HTMLDivElement = YQ.divById('title');
        titleDiv.innerText = title;
    }

    showList() {
        const listDIV: HTMLDivElement = YQ.divById('list');
        const prizes = window.g_confdata.prize;
        let i = 0;
        for (const key in prizes) {
            const prize: string | number[] = prizes[key];
            const prizeName: string = prize[0] as string;
            const prizeNumber: number = prize[1] as number;
            const prizeNameDiv: HTMLDivElement = document.createElement('div');
            prizeNameDiv.className = 'prizeName';
            prizeNameDiv.id = prizeNameDiv.className + i.toString();
            prizeNameDiv.innerHTML = '<i class="arrowi arrowDown"></i>' + prizeName;
            console.log(prizeName);
            listDIV.appendChild(prizeNameDiv);
            const prizeNowList: HTMLDivElement = document.createElement('div');
            prizeNowList.className = 'prizeSubList';
            prizeNowList.id = prizeNowList.className + i.toString();
            for (let j = 0; j < prizeNumber; j++) {
                const prizeUserDiv: HTMLDivElement = document.createElement('div');
                prizeUserDiv.className = 'prizeUser';
                prizeUserDiv.id = prizeUserDiv.className + j.toString();
                prizeUserDiv.className += ' t' + prizeNameDiv.id;
                prizeUserDiv.innerText = '尚未揭晓';
                prizeNowList.appendChild(prizeUserDiv);
            }
            listDIV.appendChild(prizeNowList);
            i++;
        }
    }
}