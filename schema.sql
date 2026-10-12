-- Mi Despensa: ejecutar en Supabase > SQL Editor.
-- Modelo deliberadamente sencillo: una cuenta familiar compartida por los móviles.
-- RLS limita todos los registros al usuario autenticado. No habilita acceso anónimo.
create table if not exists public.pantry_items (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  name text not null check (char_length(name) between 1 and 100),
  quantity text not null default '1',
  category text not null default 'Otros',
  expiry_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.shopping_items (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  name text not null check (char_length(name) between 1 and 100),
  quantity text not null default '1',
  category text not null default 'Otros',
  bought boolean not null default false,
  created_at timestamptz not null default now()
);
alter table public.pantry_items enable row level security;
alter table public.shopping_items enable row level security;
drop policy if exists "pantry select own" on public.pantry_items;
drop policy if exists "pantry insert own" on public.pantry_items;
drop policy if exists "pantry update own" on public.pantry_items;
drop policy if exists "pantry delete own" on public.pantry_items;
create policy "pantry select own" on public.pantry_items for select to authenticated using (owner_id = (select auth.uid()));
create policy "pantry insert own" on public.pantry_items for insert to authenticated with check (owner_id = (select auth.uid()));
create policy "pantry update own" on public.pantry_items for update to authenticated using (owner_id = (select auth.uid())) with check (owner_id = (select auth.uid()));
create policy "pantry delete own" on public.pantry_items for delete to authenticated using (owner_id = (select auth.uid()));
drop policy if exists "shopping select own" on public.shopping_items;
drop policy if exists "shopping insert own" on public.shopping_items;
drop policy if exists "shopping update own" on public.shopping_items;
drop policy if exists "shopping delete own" on public.shopping_items;
create policy "shopping select own" on public.shopping_items for select to authenticated using (owner_id = (select auth.uid()));
create policy "shopping insert own" on public.shopping_items for insert to authenticated with check (owner_id = (select auth.uid()));
create policy "shopping update own" on public.shopping_items for update to authenticated using (owner_id = (select auth.uid())) with check (owner_id = (select auth.uid()));
create policy "shopping delete own" on public.shopping_items for delete to authenticated using (owner_id = (select auth.uid()));
create index if not exists pantry_owner_idx on public.pantry_items(owner_id);
create index if not exists shopping_owner_idx on public.shopping_items(owner_id);
