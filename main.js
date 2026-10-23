// Данные для 5 модулей (аналог StackLayout из Main.qml)
const screens = [
  {
    icon: "📦",
    title: "КАТАЛОГ ОБОРУДОВАНИЯ",
    desc: "Витрина: оптовые градации, тех. спеки в превью, EAC сертификаты"
  },
  {
    icon: "🚚",
    title: "ТРЕКИНГ И ДОСТАВКА",
    desc: "Контроль упаковки (ESD, обрешетка), сопроводительные УПД/акты"
  },
  {
    icon: "💬",
    title: "ИНЖЕНЕРНЫЕ ЧАТЫ И ТОРГ",
    desc: "Прямой диалог покупателя и вендора, протоколы согласования цен"
  },
  {
    icon: "⚡",
    title: "ТЕХНИЧЕСКИЙ ФОРУМ И WIKI",
    desc: "Обсуждение ревизий чипов, дампы прошивок, обмен схемами"
  },
  {
    icon: "🏷",
    title: "КАБИНЕТ ВЕНДОРА / ПОСТАВЩИКА",
    desc: "Генерация лотов через нейросеть, комплаенс РФ, оптовые сетки цен"
  }
];

let currentIndex = 0;

// Рендер экрана
function renderScreen(index) {
  const content = document.getElementById('appContent');
  const screen = screens[index];
  
  content.innerHTML = `
    <div>
      <div style="font-size: 32px; margin-bottom: 12px;">${screen.icon}</div>
      <h3>${screen.title}</h3>
      <p>${screen.desc}</p>
    </div>
  `;
}

// Переключение вкладок
function switchTab(index) {
  currentIndex = index;
  
  // Обновить активную кнопку
  document.querySelectorAll('.dock-btn').forEach((btn, i) => {
    btn.classList.toggle('active', i === index);
  });
  
  // Рендерить экран
  renderScreen(index);
}

// Инициализация
document.addEventListener('DOMContentLoaded', () => {
  // Рендерить первый экран
  renderScreen(0);
  
  // Обработчики кликов на кнопки дока
  document.querySelectorAll('.dock-btn').forEach((btn, index) => {
    btn.addEventListener('click', () => switchTab(index));
  });
});

// Плавная прокрутка к секции
function scrollToSection(sectionId) {
  const element = document.getElementById(sectionId);
  if (element) {
    element.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }
}