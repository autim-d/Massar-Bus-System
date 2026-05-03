import { useState, useEffect } from "react";
import { supabase } from "./supabaseClient";
import { 
  LayoutDashboard, 
  Bus as BusIcon, 
  MapPin, 
  Route, 
  Settings, 
  Search, 
  Bell, 
  Plus, 
  MoreHorizontal,
  Activity,
  CalendarCheck,
  CreditCard,
  Globe,
  Edit2,
  Trash2,
  Ticket,
  Loader2
} from "lucide-react";

type Language = "en" | "ar";
type MenuOption = "dashboard" | "trips" | "stations" | "buses" | "bookings" | "settings";

const dict = {
  en: {
    logo: "Massar Admin",
    dashboard: "Dashboard",
    trips: "Trips",
    stations: "Stations",
    buses: "Buses",
    bookings: "Bookings",
    settings: "Settings",
    search_placeholder: "Search anything...",
    total_buses: "Total Buses",
    total_buses_sub: "18 Active, 6 Maintenance",
    total_stations: "Total Stations",
    total_stations_sub: "5 Cities",
    todays_trips: "Today's Trips",
    todays_trips_sub: "3 In Progress, 5 Scheduled",
    recent_bookings: "Recent Bookings",
    recent_bookings_sub: "120 Paid",
    add_new: "+ Add New",
    name_id: "Name / ID",
    details: "Details",
    status: "Status",
    actions: "Actions",
    add_new_trip: "Add New Trip",
    select_route: "Select Route",
    select_bus: "Select Bus",
    departure_time: "Departure Time",
    arrival_time: "Arrival Time",
    trip_status: "Trip Status",
    cancel: "Cancel",
    save_trip: "Save Trip",
    register_new_bus: "Register New Bus",
    bus_name: "Bus Name",
    plate_number: "Plate Number",
    passenger_capacity: "Passenger Capacity",
    bus_status: "Bus Status",
    add_bus: "Add Bus",
    add_new_station: "Add New Station",
    station_name: "Station Name",
    city: "City",
    latitude: "Latitude",
    longitude: "Longitude",
    add_station: "Add Station",
    status_active: "Active",
    status_pending: "Pending",
    status_maintenance: "Maintenance",
    status_completed: "Completed",
    manage_buses: "Manage Buses",
    manage_stations: "Manage Stations",
    manage_trips: "Manage Trips",
    manage_bookings: "Manage Bookings",
    recent_activity: "Recent Activity",
    add_new_booking: "Add New Booking",
    passenger_name: "Passenger Name",
    phone_number: "Phone Number",
    seat_number: "Seat Number",
    payment_status: "Payment Status",
    save_booking: "Save Booking",
    paid: "Paid",
    unpaid: "Unpaid"
  },
  ar: {
    logo: "مسار أدمن",
    dashboard: "لوحة القيادة",
    trips: "الرحلات",
    stations: "المحطات",
    buses: "الحافلات",
    bookings: "الحجوزات",
    settings: "الإعدادات",
    search_placeholder: "ابحث عن أي شيء...",
    total_buses: "إجمالي الحافلات",
    total_buses_sub: "18 نشطة، 6 صيانة",
    total_stations: "إجمالي المحطات",
    total_stations_sub: "5 مدن",
    todays_trips: "رحلات اليوم",
    todays_trips_sub: "3 جارية، 5 مجدولة",
    recent_bookings: "الحجوزات الأخيرة",
    recent_bookings_sub: "120 مدفوعة",
    add_new: "+ إضافة جديد",
    name_id: "الاسم / المعرف",
    details: "التفاصيل",
    status: "الحالة",
    actions: "إجراءات",
    add_new_trip: "إضافة رحلة جديدة",
    select_route: "اختر المسار",
    select_bus: "اختر الحافلة",
    departure_time: "وقت المغادرة",
    arrival_time: "وقت الوصول",
    trip_status: "حالة الرحلة",
    cancel: "إلغاء",
    save_trip: "حفظ الرحلة",
    register_new_bus: "تسجيل حافلة جديدة",
    bus_name: "اسم الحافلة",
    plate_number: "رقم اللوحة",
    passenger_capacity: "سعة الركاب",
    bus_status: "حالة الحافلة",
    add_bus: "إضافة حافلة",
    add_new_station: "إضافة محطة جديدة",
    station_name: "اسم المحطة",
    city: "المدينة",
    latitude: "خط العرض",
    longitude: "خط الطول",
    add_station: "إضافة محطة",
    status_active: "نشط",
    status_pending: "قيد الانتظار",
    status_maintenance: "صيانة",
    status_completed: "مكتمل",
    manage_buses: "إدارة الحافلات",
    manage_stations: "إدارة المحطات",
    manage_trips: "إدارة الرحلات",
    manage_bookings: "إدارة الحجوزات",
    recent_activity: "النشاط الأخير",
    add_new_booking: "إضافة حجز جديد",
    passenger_name: "اسم الراكب",
    phone_number: "رقم الهاتف",
    seat_number: "رقم المقعد",
    payment_status: "حالة الدفع",
    save_booking: "حفظ الحجز",
    paid: "مدفوع",
    unpaid: "غير مدفوع"
  }
};

export function AdminDashboard() {
  const [lang, setLang] = useState<Language>("en");
  const [activeMenu, setActiveMenu] = useState<MenuOption>("dashboard");
  const [loading, setLoading] = useState(true);
  
  // Data State
  const [buses, setBuses] = useState<any[]>([]);
  const [stations, setStations] = useState<any[]>([]);
  const [trips, setTrips] = useState<any[]>([]);
  const [bookings, setBookings] = useState<any[]>([]);

  // Bus Form State
  const [busForm, setBusForm] = useState({
    name: "",
    plate_number: "",
    capacity: 50,
    status: "active"
  });

  // Station Form State
  const [stationForm, setStationForm] = useState({
    name: "",
    city: "",
    latitude: "",
    longitude: ""
  });

  // Trip Form State
  const [tripForm, setTripForm] = useState({
    route_id: "",
    bus_id: "",
    departure_time: "",
    arrival_time: "",
    status: "scheduled"
  });

  const t = dict[lang];

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    setLoading(true);
    try {
      const { data: busesData } = await supabase.from('buses').select('*').order('created_at', { ascending: false });
      const { data: stationsData } = await supabase.from('stations').select('*').order('created_at', { ascending: false });
      const { data: tripsData } = await supabase.from('trips').select('*').order('created_at', { ascending: false });
      const { data: bookingsData } = await supabase.from('bookings').select('*').order('created_at', { ascending: false });

      setBuses(busesData || []);
      setStations(stationsData || []);
      setTrips(tripsData || []);
      setBookings(bookingsData || []);
    } catch (error) {
      console.error("Error fetching data:", error);
    } finally {
      setLoading(false);
    }
  };

  // Handlers
  const handleAddBus = async () => {
    if (!busForm.name || !busForm.plate_number) return alert("Please fill all fields");
    const { error } = await supabase.from('buses').insert([busForm]);
    if (error) alert(error.message);
    else {
      setBusForm({ name: "", plate_number: "", capacity: 50, status: "active" });
      fetchData();
    }
  };

  const handleAddStation = async () => {
    if (!stationForm.name || !stationForm.city) return alert("Please fill all fields");
    const { error } = await supabase.from('stations').insert([stationForm]);
    if (error) alert(error.message);
    else {
      setStationForm({ name: "", city: "", latitude: "", longitude: "" });
      fetchData();
    }
  };

  const handleAddTrip = async () => {
    if (!tripForm.departure_time || !tripForm.arrival_time) return alert("Please fill all fields");
    const { error } = await supabase.from('trips').insert([tripForm]);
    if (error) alert(error.message);
    else {
      setTripForm({ route_id: "", bus_id: "", departure_time: "", arrival_time: "", status: "scheduled" });
      fetchData();
    }
  };

  const toggleLanguage = () => {
    setLang(prev => prev === "en" ? "ar" : "en");
  };

  const getStatusStyle = (status: string) => {
    switch(status) {
      case 'active':
      case 'paid':
        return 'bg-emerald-50 text-emerald-700 border-emerald-200';
      case 'pending':
      case 'unpaid':
        return 'bg-amber-50 text-amber-700 border-amber-200';
      case 'completed':
        return 'bg-blue-50 text-blue-700 border-blue-200';
      default:
        return 'bg-slate-100 text-slate-700 border-slate-200';
    }
  };

  const getStatusLabel = (status: string) => {
    switch(status) {
      case 'active': return t.status_active;
      case 'pending': return t.status_pending;
      case 'maintenance': return t.status_maintenance;
      case 'completed': return t.status_completed;
      case 'paid': return t.paid;
      case 'unpaid': return t.unpaid;
      default: return status;
    }
  };

  const renderTable = (data: any[], type: 'buses' | 'stations' | 'trips' | 'bookings') => {
    if (loading) return (
      <div className="bg-white border border-gray-200 rounded-xl shadow-sm p-12 flex flex-col items-center justify-center">
        <Loader2 className="w-8 h-8 text-[#1e3a8a] animate-spin mb-3" />
        <p className="text-sm text-slate-500 font-medium">Loading data...</p>
      </div>
    );

    return (
      <div className="bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-start border-collapse">
            <thead>
              <tr className="bg-gray-50/80 border-b border-gray-200 text-xs uppercase tracking-wider text-slate-500">
                <th className="py-3 px-5 font-semibold text-start">{t.name_id}</th>
                <th className="py-3 px-5 font-semibold text-start">{t.details}</th>
                <th className="py-3 px-5 font-semibold text-start">{t.status}</th>
                <th className="py-3 px-5 font-semibold text-end">{t.actions}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {data.map((row) => {
                let name = row.name;
                let id = row.id;
                let details = "";

                if (type === 'buses') {
                  details = `Plate: ${row.plate_number} • Capacity: ${row.capacity}`;
                } else if (type === 'stations') {
                  details = `City: ${row.city} • Lat: ${row.latitude}, Lng: ${row.longitude}`;
                } else if (type === 'trips') {
                  details = `Bus: ${row.bus_id} • Dep: ${row.departure_time}`;
                } else if (type === 'bookings') {
                  name = row.passenger_name;
                  details = `Trip: ${row.trip_id} • Seat: ${row.seat_number}`;
                }

                return (
                  <tr key={row.id} className="hover:bg-gray-50/50 transition-colors group">
                    <td className="py-3 px-5">
                      <p className="text-sm font-semibold text-slate-800">{name}</p>
                      <p className="text-xs text-slate-500 mt-0.5">{id}</p>
                    </td>
                    <td className="py-3 px-5">
                      <p className="text-sm text-slate-600">{details}</p>
                    </td>
                    <td className="py-3 px-5">
                      <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium border ${getStatusStyle(row.status)}`}>
                        {getStatusLabel(row.status)}
                      </span>
                    </td>
                    <td className="py-3 px-5 text-end">
                      <div className="flex items-center justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button className="p-1.5 text-slate-400 hover:text-[#1e3a8a] rounded hover:bg-[#1e3a8a]/5 transition-colors">
                          <Edit2 className="w-4 h-4" />
                        </button>
                        <button className="p-1.5 text-slate-400 hover:text-rose-600 rounded hover:bg-rose-50 transition-colors">
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    );
  };

  return (
    <div 
      className="flex h-screen bg-white text-slate-800 font-sans transition-all duration-300" 
      dir={lang === "ar" ? "rtl" : "ltr"}
    >
      {/* Left Sidebar */}
      <aside className="w-64 bg-gray-100 border-e border-gray-200 flex flex-col hidden md:flex shrink-0">
        <div className="h-16 flex items-center px-6 border-b border-gray-200">
          <div className="flex items-center gap-2 text-[#1e3a8a]">
            <Route className="w-6 h-6" strokeWidth={2.5} />
            <span className="text-xl font-bold tracking-tight">{t.logo}</span>
          </div>
        </div>
        
        <nav className="flex-1 py-6 px-4 space-y-1">
          <button 
            onClick={() => setActiveMenu("dashboard")}
            className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg font-medium transition-colors ${activeMenu === "dashboard" ? "bg-[#1e3a8a] text-white shadow-sm" : "text-slate-600 hover:bg-gray-200 hover:text-[#1e3a8a]"}`}
          >
            <LayoutDashboard className={`w-5 h-5 ${activeMenu === "dashboard" ? "opacity-90" : "opacity-70"}`} />
            <span className="text-sm">{t.dashboard}</span>
          </button>
          <button 
            onClick={() => setActiveMenu("trips")}
            className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg font-medium transition-colors ${activeMenu === "trips" ? "bg-[#1e3a8a] text-white shadow-sm" : "text-slate-600 hover:bg-gray-200 hover:text-[#1e3a8a]"}`}
          >
            <Route className={`w-5 h-5 ${activeMenu === "trips" ? "opacity-90" : "opacity-70"}`} />
            <span className="text-sm">{t.trips}</span>
          </button>
          <button 
            onClick={() => setActiveMenu("stations")}
            className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg font-medium transition-colors ${activeMenu === "stations" ? "bg-[#1e3a8a] text-white shadow-sm" : "text-slate-600 hover:bg-gray-200 hover:text-[#1e3a8a]"}`}
          >
            <MapPin className={`w-5 h-5 ${activeMenu === "stations" ? "opacity-90" : "opacity-70"}`} />
            <span className="text-sm">{t.stations}</span>
          </button>
          <button 
            onClick={() => setActiveMenu("buses")}
            className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg font-medium transition-colors ${activeMenu === "buses" ? "bg-[#1e3a8a] text-white shadow-sm" : "text-slate-600 hover:bg-gray-200 hover:text-[#1e3a8a]"}`}
          >
            <Bus className={`w-5 h-5 ${activeMenu === "buses" ? "opacity-90" : "opacity-70"}`} />
            <span className="text-sm">{t.buses}</span>
          </button>
          <button 
            onClick={() => setActiveMenu("bookings")}
            className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg font-medium transition-colors ${activeMenu === "bookings" ? "bg-[#1e3a8a] text-white shadow-sm" : "text-slate-600 hover:bg-gray-200 hover:text-[#1e3a8a]"}`}
          >
            <Ticket className={`w-5 h-5 ${activeMenu === "bookings" ? "opacity-90" : "opacity-70"}`} />
            <span className="text-sm">{t.bookings}</span>
          </button>
          <button 
            onClick={() => setActiveMenu("settings")}
            className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg font-medium transition-colors ${activeMenu === "settings" ? "bg-[#1e3a8a] text-white shadow-sm" : "text-slate-600 hover:bg-gray-200 hover:text-[#1e3a8a]"}`}
          >
            <Settings className={`w-5 h-5 ${activeMenu === "settings" ? "opacity-90" : "opacity-70"}`} />
            <span className="text-sm">{t.settings}</span>
          </button>
        </nav>
      </aside>

      {/* Main Content Area */}
      <div className="flex-1 flex flex-col overflow-hidden bg-[#f8fafc]">
        {/* Top Header */}
        <header className="h-16 bg-white border-b border-gray-200 flex items-center justify-between px-6 z-10 shrink-0">
          <div className="flex items-center flex-1 max-w-md">
            <div className="relative w-full">
              <Search className="absolute start-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
              <input 
                type="text" 
                placeholder={t.search_placeholder}
                className="w-full ps-10 pe-4 py-2 bg-gray-50 border border-gray-200 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-[#1e3a8a]/20 focus:border-[#1e3a8a] transition-all"
              />
            </div>
          </div>
          <div className="flex items-center gap-3 sm:gap-5">
            <button 
              onClick={toggleLanguage}
              className="flex items-center gap-1.5 px-3 py-1.5 rounded-md text-sm font-medium text-slate-600 hover:bg-gray-100 transition-colors border border-gray-200"
            >
              <Globe className="w-4 h-4" />
              <span className="hidden sm:inline">{lang === "en" ? "EN / AR" : "عربي / EN"}</span>
            </button>
            <button className="relative p-2 text-gray-400 hover:text-[#1e3a8a] transition-colors rounded-full hover:bg-gray-50">
              <Bell className="w-5 h-5" />
              <span className="absolute top-1.5 end-1.5 w-2 h-2 bg-rose-500 rounded-full border border-white"></span>
            </button>
            <div className="h-8 border-s border-gray-200 mx-1"></div>
            <div className="w-9 h-9 rounded-full bg-[#1e3a8a]/10 flex items-center justify-center text-[#1e3a8a] font-semibold border border-[#1e3a8a]/20 cursor-pointer overflow-hidden">
              <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="Profile" className="w-full h-full object-cover" />
            </div>
          </div>
        </header>

        {/* Scrollable Main Area */}
        <main className="flex-1 overflow-auto p-6 lg:p-8">
          <div className="max-w-[1600px] mx-auto space-y-8">
            
            {/* Dashboard View */}
            {activeMenu === "dashboard" && (
              <>
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 lg:gap-6">
                  <div className="bg-white p-5 rounded-xl border border-gray-200 shadow-sm flex flex-col justify-between">
                    <div className="flex items-center justify-between mb-3">
                      <h3 className="text-sm font-medium text-slate-500">{t.total_buses}</h3>
                      <div className="w-8 h-8 rounded-md bg-[#1e3a8a]/10 flex items-center justify-center text-[#1e3a8a]">
                        <BusIcon className="w-4 h-4" />
                      </div>
                    </div>
                    <div>
                      <p className="text-3xl font-bold text-slate-800">{buses.length}</p>
                      <p className="text-xs text-slate-500 font-medium mt-1">{t.total_buses_sub}</p>
                    </div>
                  </div>
                  <div className="bg-white p-5 rounded-xl border border-gray-200 shadow-sm flex flex-col justify-between">
                    <div className="flex items-center justify-between mb-3">
                      <h3 className="text-sm font-medium text-slate-500">{t.total_stations}</h3>
                      <div className="w-8 h-8 rounded-md bg-[#1e3a8a]/10 flex items-center justify-center text-[#1e3a8a]">
                        <MapPin className="w-4 h-4" />
                      </div>
                    </div>
                    <div>
                      <p className="text-3xl font-bold text-slate-800">{stations.length}</p>
                      <p className="text-xs text-slate-500 mt-1">{t.total_stations_sub}</p>
                    </div>
                  </div>
                  <div className="bg-white p-5 rounded-xl border border-gray-200 shadow-sm flex flex-col justify-between">
                    <div className="flex items-center justify-between mb-3">
                      <h3 className="text-sm font-medium text-slate-500">{t.todays_trips}</h3>
                      <div className="w-8 h-8 rounded-md bg-[#1e3a8a]/10 flex items-center justify-center text-[#1e3a8a]">
                        <Activity className="w-4 h-4" />
                      </div>
                    </div>
                    <div>
                      <p className="text-3xl font-bold text-slate-800">{trips.length}</p>
                      <p className="text-xs text-slate-500 mt-1">{t.todays_trips_sub}</p>
                    </div>
                  </div>
                  <div className="bg-white p-5 rounded-xl border border-gray-200 shadow-sm flex flex-col justify-between">
                    <div className="flex items-center justify-between mb-3">
                      <h3 className="text-sm font-medium text-slate-500">{t.recent_bookings}</h3>
                      <div className="w-8 h-8 rounded-md bg-[#1e3a8a]/10 flex items-center justify-center text-[#1e3a8a]">
                        <Ticket className="w-4 h-4" />
                      </div>
                    </div>
                    <div>
                      <p className="text-3xl font-bold text-slate-800">{bookings.length}</p>
                      <p className="text-xs text-slate-500 mt-1">{t.recent_bookings_sub}</p>
                    </div>
                  </div>
                </div>

                <div>
                  <div className="flex items-center justify-between mb-4">
                    <h2 className="text-lg font-semibold text-slate-800">{t.recent_activity}</h2>
                  </div>
                  {renderTable(trips.slice(0, 5), 'trips')}
                </div>
              </>
            )}

            {activeMenu === "trips" && (
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
                <div className="lg:col-span-2 space-y-4">
                  <div className="flex items-center justify-between">
                    <h2 className="text-xl font-bold text-slate-800">{t.manage_trips}</h2>
                  </div>
                  {renderTable(trips, 'trips')}
                </div>
                <div className="bg-white border border-gray-200 rounded-xl shadow-sm p-5">
                  <h3 className="text-lg font-semibold text-slate-800 border-b border-gray-100 pb-3 mb-4">{t.add_new_trip}</h3>
                  <div className="grid grid-cols-2 gap-4">
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.select_route}</label>
                      <select 
                        value={tripForm.route_id}
                        onChange={(e) => setTripForm({...tripForm, route_id: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none"
                      >
                        <option value="">Select</option>
                        <option value="Riyadh-Jeddah">Riyadh - Jeddah</option>
                        <option value="Dammam-Riyadh">Dammam - Riyadh</option>
                      </select>
                    </div>
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.select_bus}</label>
                      <select 
                        value={tripForm.bus_id}
                        onChange={(e) => setTripForm({...tripForm, bus_id: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none"
                      >
                        <option value="">Select</option>
                        {buses.map(bus => (
                          <option key={bus.id} value={bus.id}>{bus.name} ({bus.plate_number})</option>
                        ))}
                      </select>
                    </div>
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.departure_time}</label>
                      <input 
                        type="datetime-local" 
                        value={tripForm.departure_time}
                        onChange={(e) => setTripForm({...tripForm, departure_time: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none" 
                      />
                    </div>
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.arrival_time}</label>
                      <input 
                        type="datetime-local" 
                        value={tripForm.arrival_time}
                        onChange={(e) => setTripForm({...tripForm, arrival_time: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none" 
                      />
                    </div>
                    <div className="col-span-2">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.trip_status}</label>
                      <select 
                        value={tripForm.status}
                        onChange={(e) => setTripForm({...tripForm, status: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none"
                      >
                        <option value="scheduled">Scheduled</option>
                        <option value="active">Active</option>
                        <option value="completed">Completed</option>
                      </select>
                    </div>
                    <div className="col-span-2 flex justify-end gap-2 mt-2">
                      <button 
                        onClick={() => setTripForm({ route_id: "", bus_id: "", departure_time: "", arrival_time: "", status: "scheduled" })}
                        className="px-4 py-2 text-sm font-medium text-slate-600 bg-white border border-gray-200 rounded-md hover:bg-gray-50 transition-colors"
                      >
                        {t.cancel}
                      </button>
                      <button 
                        onClick={handleAddTrip}
                        className="px-4 py-2 text-sm font-medium text-white bg-[#1e3a8a] rounded-md hover:bg-[#1e3a8a]/90 transition-colors shadow-sm"
                      >
                        {t.save_trip}
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {activeMenu === "buses" && (
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
                <div className="lg:col-span-2 space-y-4">
                  <div className="flex items-center justify-between">
                    <h2 className="text-xl font-bold text-slate-800">{t.manage_buses}</h2>
                  </div>
                  {renderTable(buses, 'buses')}
                </div>
                <div className="bg-white border border-gray-200 rounded-xl shadow-sm p-5">
                  <h3 className="text-lg font-semibold text-slate-800 border-b border-gray-100 pb-3 mb-4">{t.register_new_bus}</h3>
                  <div className="grid grid-cols-2 gap-4">
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.bus_name}</label>
                      <input 
                        type="text" 
                        placeholder="e.g. Volvo 9700" 
                        value={busForm.name}
                        onChange={(e) => setBusForm({...busForm, name: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none" 
                      />
                    </div>
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.plate_number}</label>
                      <input 
                        type="text" 
                        placeholder="e.g. KSA-1234" 
                        value={busForm.plate_number}
                        onChange={(e) => setBusForm({...busForm, plate_number: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none" 
                      />
                    </div>
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.passenger_capacity}</label>
                      <input 
                        type="number" 
                        placeholder="50" 
                        value={busForm.capacity}
                        onChange={(e) => setBusForm({...busForm, capacity: parseInt(e.target.value)})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none" 
                      />
                    </div>
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.bus_status}</label>
                      <select 
                        value={busForm.status}
                        onChange={(e) => setBusForm({...busForm, status: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none"
                      >
                        <option value="active">Active</option>
                        <option value="maintenance">Maintenance</option>
                      </select>
                    </div>
                    <div className="col-span-2 flex justify-end mt-2">
                      <button 
                        onClick={handleAddBus}
                        className="px-4 py-2 text-sm font-medium text-white bg-[#1e3a8a] rounded-md hover:bg-[#1e3a8a]/90 transition-colors shadow-sm w-full sm:w-auto"
                      >
                        {t.add_bus}
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {/* Stations View */}
            {activeMenu === "stations" && (
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
                <div className="lg:col-span-2 space-y-4">
                  <div className="flex items-center justify-between">
                    <h2 className="text-xl font-bold text-slate-800">{t.manage_stations}</h2>
                  </div>
                  {renderTable(stations, 'stations')}
                </div>
                <div className="bg-white border border-gray-200 rounded-xl shadow-sm p-5">
                  <h3 className="text-lg font-semibold text-slate-800 border-b border-gray-100 pb-3 mb-4">{t.add_new_station}</h3>
                  <div className="grid grid-cols-2 gap-4">
                    <div className="col-span-2">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.station_name}</label>
                      <input 
                        type="text" 
                        placeholder="e.g. Riyadh Central Station" 
                        value={stationForm.name}
                        onChange={(e) => setStationForm({...stationForm, name: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none" 
                      />
                    </div>
                    <div className="col-span-2">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.city}</label>
                      <input 
                        type="text" 
                        placeholder="e.g. Riyadh" 
                        value={stationForm.city}
                        onChange={(e) => setStationForm({...stationForm, city: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none" 
                      />
                    </div>
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.latitude}</label>
                      <input 
                        type="number" 
                        step="any" 
                        placeholder="24.7136" 
                        value={stationForm.latitude}
                        onChange={(e) => setStationForm({...stationForm, latitude: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none" 
                      />
                    </div>
                    <div className="col-span-2 sm:col-span-1">
                      <label className="block text-xs font-medium text-slate-600 mb-1.5">{t.longitude}</label>
                      <input 
                        type="number" 
                        step="any" 
                        placeholder="46.6753" 
                        value={stationForm.longitude}
                        onChange={(e) => setStationForm({...stationForm, longitude: e.target.value})}
                        className="w-full bg-gray-50 border border-gray-200 text-slate-800 text-sm rounded-md focus:ring-[#1e3a8a] focus:border-[#1e3a8a] block p-2.5 outline-none" 
                      />
                    </div>
                    <div className="col-span-2 flex justify-end mt-2">
                      <button 
                        onClick={handleAddStation}
                        className="px-4 py-2 text-sm font-medium text-white bg-[#1e3a8a] rounded-md hover:bg-[#1e3a8a]/90 transition-colors shadow-sm w-full sm:w-auto"
                      >
                        {t.add_station}
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {/* Bookings View */}
            {activeMenu === "bookings" && (
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
                <div className="lg:col-span-2 space-y-4">
                  <div className="flex items-center justify-between">
                    <h2 className="text-xl font-bold text-slate-800">{t.manage_bookings}</h2>
                  </div>
                  {renderTable(bookings, 'bookings')}
                </div>
                <div className="bg-white border border-gray-200 rounded-xl shadow-sm p-5">
                  <h3 className="text-lg font-semibold text-slate-800 border-b border-gray-100 pb-3 mb-4">{t.add_new_booking}</h3>
                  <div className="grid grid-cols-2 gap-4">
                    <div className="col-span-2 text-center py-6 text-slate-500 text-sm font-medium italic">
                      Bookings are typically managed from the client side.
                    </div>
                  </div>
                </div>
              </div>
            )}

          </div>
        </main>
      </div>
    </div>
  );
}